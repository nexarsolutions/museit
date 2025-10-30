import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:musit/pages/sender_side/sender_home/sender_home/sender_home_screen.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/song_service.dart';
import 'package:musit/services/upload_file_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/utils/dialog_utilities.dart';
import 'package:musit/utils/global_functions.dart';

import '../../../../../constants/app_enums.dart';
import '../../../../../globalModels/song_model.dart';
import '../../../../../globalModels/youtube_music_response_model.dart';
import '../../../../../services/spotify_auth_service.dart';
import '../../../../../services/youtube_music_service.dart';

class AddSongsController extends GetxController {
  final spotifyService = Get.find<SpotifyAuthService>(); // ✅ use global service
  final YouTubeMusicAuthService ytMusicService =
      Get.find<YouTubeMusicAuthService>();

  final RxInt songTypeId = 0.obs;
  final searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  RxList<SongModel> songs = <SongModel>[].obs;
  RxList<SongModel> librarySelected = <SongModel>[].obs;
  RxList<SongModel> library = <SongModel>[
    SongModel(
      typeId: 4,
      name: "zamona-net-indila-love-story.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761649879080-zamona-net-indila-love-story.mp3",
    ),
    SongModel(
      typeId: 4,
      name: "Ajj_Kal_Full_Song_1.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761649918475-Ajj_Kal_Full_Song_1.mp3",
    ),
    SongModel(
      typeId: 4,
      name: "Jis_Tan_Nu_Lagdi_Aye_3.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761649946413-Jis_Tan_Nu_Lagdi_Aye_3.mp3",
    ),
    SongModel(
      typeId: 4,
      name: "Dhoor_Pendi_Kaka_128_Kbps.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761649972080-Dhoor_Pendi_Kaka_128_Kbps.mp3",
    ),
    SongModel(
      typeId: 4,
      name: "128-Baazigar_O_Baazigar_-_Baazigar_128_Kbps.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761650000462-128-Baazigar_O_Baazigar_-_Baazigar_128_Kbps.mp3",
    ),
    SongModel(
      typeId: 4,
      name: "bollywood_KK_1976_-_Kabhi_Kabhi_Mere_Dil.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761650025866-bollywood_KK_1976_-_Kabhi_Kabhi_Mere_Dil.mp3",
    ),
    SongModel(
      typeId: 4,
      name: "Nainowale_Ne_(Padmaavat)_320_Kbps.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761650066022-Nainowale_Ne_%28Padmaavat%29_320_Kbps.mp3",
    ),
  ].obs;

  final RxList<Map<String, dynamic>> searchSpotifyResults =
      <Map<String, dynamic>>[].obs;
  final RxList<YoutubeSongModel> searchYoutubeResults =
      <YoutubeSongModel>[].obs;
  final RxBool isSpotifyLoading = false.obs;
  final RxBool isYoutubeLoading = false.obs;

  // Default fallback songs
  final defaultSongs = [
    "Shape of You",
    "Blinding Lights",
    "Stay",
    "Believer",
    "Dance Monkey",
    "Perfect",
    "Peaches"
  ];

  @override
  void onInit() {
    super.onInit();
    debounce(searchQuery, (query) {
      if (songTypeId.value == 0) {
        query.toString().isEmpty
            ? loadDefaultSongs()
            : searchSong(query.toString());
      } else if (songTypeId.value == 1) {
        loadYoutubeSongs(search: query);
      }
    }, time: const Duration(milliseconds: 600));

    ever(spotifyService.isConnected, (connected) {
      if (connected == true) loadDefaultSongs();
    });

    ever(ytMusicService.isConnected, (connected) {
      if (connected == true) loadYoutubeSongs();
    });

    ever(
      songTypeId,
      (typeid) {
        if (typeid == 0) {
          loadDefaultSongs();
        } else if (typeid == 1) {
          loadYoutubeSongs();
        }
      },
    );
  }

  Future<void> loadYoutubeSongs({String search = ''}) async {
    try {
      isYoutubeLoading.value = true;
      var url = 'youtube-music/songs?limit=10';
      if (search != '') {
        url += '&query=$search';
      }

      await ytMusicService.connectYouTubeMusic();
      await ApiService().handleGetResponse(
        apiMethod: () async => await ApiService().get(url),
        onSuccess: (success) {
          final services = YoutubeMusicResponseModel.fromJson(success);
          final songs = services.response?.songs ?? [];
          searchYoutubeResults.assignAll(songs);
        },
        onError: (error) {
          songs.clear();
          isYoutubeLoading.value = false;
        },
      );
    } catch (e) {
      isYoutubeLoading.value = false;
    } finally {
      isYoutubeLoading.value = false;
    }
  }

  Future<void> searchSong(String query) async {
    // print("************* 0");
    if (query.isEmpty) return loadDefaultSongs();

    isSpotifyLoading.value = true;
    final token = await spotifyService.getAccessToken();
    print("************* 1\n$token");
    if (token == null) {
      isSpotifyLoading.value = false;
      return;
    }

    final url = Uri.parse(
        'https://api.spotify.com/v1/search?q=$query&type=track&limit=10');
    final res =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    // print("************* 2\n${res.body}");

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final List items = data['tracks']['items'];
      searchSpotifyResults.assignAll(items.map((track) {
        printInfo(info: track['name'].toString());
        printInfo(info: track['uri'].toString());
        printInfo(info: track['album']['images'][0]['url'].toString());
        printInfo(info: track['preview_url'].toString());
        return {
          'name': track['name'],
          'artist': track['artists'][0]['name'],
          'uri': track['uri'],
          'image': track['album']['images'][0]['url'],
          'preview': track['preview_url']
        };
      }).toList());
    } else {
      searchSpotifyResults.clear();
    }
    isSpotifyLoading.value = false;
  }

  Future<void> loadDefaultSongs() async {
    if (!spotifyService.isConnected.value) return;
    await searchSong(defaultSongs.first);
  }

  Future<void> shareSong(List<SongModel> voiceRecordings,
      String? receiverPhoneNumber, List<int> selectedUsers) async {
    try {
      loadingDialog();
      List<Map<AudioKey, dynamic>> voices = [];
      if (voiceRecordings.isNotEmpty) {
        for (var voice in voiceRecordings) {
          final voicePath = await UploadFileService()
              .fileUploadResult(uploadData: voice.link ?? '');

          if (voicePath != null) {
            voices.add(
                {AudioKey.path: voicePath, AudioKey.name: voice.name ?? ''});
          } else {
            Get.back();
            return;
          }
        }
      }

      for (var s in librarySelected) {
        songs.add(s);
      }

      var data = {
        'songs': songs
            .map(
              (song) => song.toJson(),
            )
            .toList(),
        if (voices.isNotEmpty)
          'voiceNotes': voices
              .map((e) => {'name': e[AudioKey.name], 'link': e[AudioKey.path]})
              .toList(),
        if (selectedUsers.isNotEmpty)
          'toUserIds': selectedUsers
              .map(
                (user) => user,
              )
              .toList(),
        if (receiverPhoneNumber != null && receiverPhoneNumber != '')
          'phoneNumber': receiverPhoneNumber,
      };
      Get.back(); //close loading dialog
      await ApiService().handleResponse(
        apiMethod: () => SongService().shareSongs(data),
        onSuccess: (Map<String, dynamic> response) {
          customPrint("add_songs_controller line 64: $response");
          Get.offAll(() => SenderHomeScreen());
          customErrorSnackBar(content: response['message']);
        },
      );
    } catch (e) {
      Get.back(); //close loading dialog
      errorDialog(content: e.toString());
    }
  }
}
