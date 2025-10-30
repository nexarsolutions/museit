import 'dart:convert';

import 'package:dart_ytmusic_api/types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:musit/globalModels/admin_songs_model.dart';
import 'package:musit/pages/sender_side/sender_home/sender_home/sender_home_screen.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/song_service.dart';
import 'package:musit/services/upload_file_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/utils/dialog_utilities.dart';
import 'package:musit/utils/global_functions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../constants/app_enums.dart';
import '../../../../../globalModels/song_model.dart';
import '../../../../../globalModels/youtube_music_response_model.dart';
import '../../../../../main.dart';
import '../../../../../services/spotify_auth_service.dart';
import '../../../../../services/youtube_music_service.dart';
import '../../../../sendBottombar/sender_bottom_bar.dart';

class AddSongsController extends GetxController {
  final spotifyService = Get.find<SpotifyAuthService>(); // ✅ use global service
  // final YouTubeMusicAuthService ytMusicService =
  //     Get.find<YouTubeMusicAuthService>();

  final RxInt songTypeId = 0.obs;
  final searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  RxList<SongModel> songs = <SongModel>[].obs;

  // RxList<SongModel> librarySelected = <SongModel>[].obs;
  RxList<SongModel> adminSongs = <SongModel>[].obs;

  final RxList<Map<String, dynamic>> searchSpotifyResults =
      <Map<String, dynamic>>[].obs;
  final RxList<SongDetailed> searchYoutubeResults = <SongDetailed>[].obs;
  final RxBool isSpotifyLoading = false.obs;
  final RxBool isYoutubeLoading = false.obs;
  final RxBool isAdminSongsLoading = false.obs;

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
        // loadYoutubeSongs(search: query);
        searchYoutubeSongs(query: query);
      }
    }, time: const Duration(milliseconds: 600));

    ever(spotifyService.isConnected, (connected) {
      if (connected == true) loadDefaultSongs();
    });

    // ever(ytMusicService.isConnected, (connected) {
    //   if (connected == true) loadYoutubeSongs();
    // });

    ever(
      songTypeId,
      (typeid) {
        if (typeid == 0) {
          loadDefaultSongs();
        } else if (typeid == 1) {
          searchYoutubeSongs();
        }
      },
    );
  }

  Future<List<AdminSongsModel>> loadAdminSongs({String search = ''}) async {
    try {
      List<AdminSongsModel> adSongs = [];
      await ApiService().handleGetResponse(
        apiMethod: () => SongService().loadAdminSongs(search: search),
        onSuccess: (Map<String, dynamic> response) {
          final success = AdminSongsResponseModel.fromJson(response);
          final newList = success.response?.rows ?? [];
          adSongs.assignAll(newList);
        },
        onError: (error) {
          throw Exception(error);
        },
      );
      return adSongs;
    } catch (e) {
      rethrow;
    }
  }

  /// Searches for songs by the given query and prints the results.
  Future<void> searchYoutubeSongs({String query = ''}) async {
    // try {
    //   isYoutubeLoading.value = true;
    searchYoutubeResults.clear();
    final results = await ytmusic.searchSongs(query == '' ? 'Top' : query);
    for (final result in results) {
      searchYoutubeResults.add(result);
    }
    // } catch (e) {
    //   print("youtube search error: $e");
    // } finally {
    //   isYoutubeLoading.value = false;
    // }
  }

  Future<void> searchSong(String query) async {
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

      // for (var s in librarySelected) {
      //   songs.add(s);
      // }

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
          Get.offAll(() => SenderBottomBar());
          customErrorSnackBar(content: response['message']);
        },
      );
    } catch (e) {
      Get.back(); //close loading dialog
      errorDialog(content: e.toString());
    }
  }

  Future<void> shareMomentExternally(List<SongModel> songs, String platform,
      {String? receiver}) async {
    // Generate a message text
    String message = "Hey! Check out these songs I shared on MUSEiT 🎵\n\n";
    for (var song in songs) {
      message += "${song.name}\n";
      if (song.link != null) {
        if (song.typeId == 1) {
          String trackId = song.link.toString().split(':').last;
          message += 'https://open'
              '.spotify'
              '.com/embed/track/$trackId';
        } else if (song.typeId == 2) {
          message += 'https://www.youtube'
              '.com/watch?v=${song.link ?? ''}';
        }

        message += "${song.link}\n";
      }
    }
    // Optionally, add your app deep link
    message += "\nListen on MUSEiT: https://museit.app/moment";

    Uri uri;
    switch (platform) {
      case 'SMS':
        uri = Uri.parse(
            "sms:${receiver ?? ''}?body=${Uri.encodeComponent(message)}");
        break;
      case 'WhatsApp':
        uri = Uri.parse(
            "https://wa.me/${receiver ?? ''}?text=${Uri.encodeComponent(message)}");
        break;
      case 'Email':
        uri = Uri(
          scheme: 'mailto',
          path: receiver ?? '',
          query:
              'subject=${Uri.encodeComponent("MUSEiT Moment")}&body=${Uri.encodeComponent(message)}',
        );
        break;
      default:
        throw "Unsupported platform";
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
