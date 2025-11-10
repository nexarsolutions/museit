import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:musit/globalModels/admin_songs_model.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/song_service.dart';
import 'package:musit/services/upload_file_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/utils/dialog_utilities.dart';
import 'package:musit/utils/global_functions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../constants/app_enums.dart';
import '../../../../../globalModels/song_model.dart';
import '../../../../../main.dart';
import '../../../../../services/spotify_auth_service.dart';
import '../../../../sendBottombar/sender_bottom_bar.dart';

class AddSongsController extends GetxController {
  final spotifyService = Get.find<SpotifyAuthService>(); // ✅ use global service
  // final YouTubeMusicAuthService ytMusicService =
  //     Get.find<YouTubeMusicAuthService>();

  final List<String> songUrls = [
    'https://www.youtube.com/watch?v=pO40TcKa_5U',
    'https://www.youtube.com/watch?v=OygsHbM1UCw',
    'https://www.youtube.com/watch?v=G5QPirQITZI',
    'https://www.youtube.com/watch?v=e5iqtQLm-BM',
    'https://www.youtube.com/watch?v=Wmc8bQoL-J0',
  ];

  final RxInt songTypeId = 0.obs;
  final searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  RxList<SongModel> songs = <SongModel>[].obs;

  // RxList<SongModel> librarySelected = <SongModel>[].obs;
  RxList<SongModel> adminSongs = <SongModel>[].obs;

  final RxList<Map<String, dynamic>> searchSpotifyResults =
      <Map<String, dynamic>>[].obs;

final RxList<Map<String, String>> searchInYoutubeList=<Map<String, String>>[].obs;
  final RxList<Map<String, String>> youtubeSongsList = [
    {
      "name": "You Gotta Be — Des'ree",
      "videoId": "pO40TcKa_5U",
      "thumbnail": "https://img.youtube.com/vi/pO40TcKa_5U/maxresdefault.jpg"
    },
    {
      "name": "Proud — Heather Small",
      "videoId": "OygsHbM1UCw",
      "thumbnail": "https://img.youtube.com/vi/OygsHbM1UCw/maxresdefault.jpg"
    },
    {
      "name": "Shine Ya Light — Rita Ora",
      "videoId": "DH182aLsVig",
      "thumbnail": "https://img.youtube.com/vi/DH182aLsVig/maxresdefault.jpg"
    },
    {
      "name": "Dreams — Gabrielle",
      "videoId": "G5QPirQITZI",
      "thumbnail": "https://img.youtube.com/vi/G5QPirQITZI/maxresdefault.jpg"
    },
    {
      "name": "Hold On — Skepta",
      "videoId": "e5iqtQLm-BM",
      "thumbnail": "https://img.youtube.com/vi/e5iqtQLm-BM/maxresdefault.jpg"
    },
    {
      "name": "Mr Brightside — The Killers",
      "videoId": "gGdGFtwCNBE",
      "thumbnail": "https://img.youtube.com/vi/gGdGFtwCNBE/maxresdefault.jpg"
    },
    {
      "name": "Don’t You Want Me — The Human League",
      "videoId": "uPudE8nDog0",
      "thumbnail": "https://img.youtube.com/vi/uPudE8nDog0/maxresdefault.jpg"
    },
    {
      "name": "Don’t Stop Movin’ — S Club 7",
      "videoId": "vm262cXxRrU",
      "thumbnail": "https://img.youtube.com/vi/vm262cXxRrU/maxresdefault.jpg"
    },
    {
      "name": "Starlight — Muse",
      "videoId": "Pgum6OT_VH8",
      "thumbnail": "https://img.youtube.com/vi/Pgum6OT_VH8/maxresdefault.jpg"
    },
    {
      "name": "We R Who We R — Kesha",
      "videoId": "Q97c5szTgIA",
      "thumbnail": "https://img.youtube.com/vi/Q97c5szTgIA/maxresdefault.jpg"
    },
    {
      "name": "Survivor — Destiny’s Child",
      "videoId": "Wmc8bQoL-J0",
      "thumbnail": "https://img.youtube.com/vi/Wmc8bQoL-J0/maxresdefault.jpg"
    },
    {
      "name": "Girl on Fire — Alicia Keys",
      "videoId": "J91ti_MpdHA",
      "thumbnail": "https://img.youtube.com/vi/J91ti_MpdHA/maxresdefault.jpg"
    },
    {
      "name": "Let It Be — The Beatles",
      "videoId": "QDYfEBY9NM4",
      "thumbnail": "https://img.youtube.com/vi/QDYfEBY9NM4/maxresdefault.jpg"
    },
    {
      "name": "Don’t Give Up — Peter Gabriel & Kate Bush",
      "videoId": "VjEq-r2agqc",
      "thumbnail": "https://img.youtube.com/vi/VjEq-r2agqc/maxresdefault.jpg"
    },
    {
      "name": "Express Yourself — Madonna",
      "videoId": "GsVcUzP_O_8",
      "thumbnail": "https://img.youtube.com/vi/GsVcUzP_O_8/maxresdefault.jpg"
    },
    {
      "name": "What a Wonderful World — Louis Armstrong",
      "videoId": "CWzrABouyeE",
      "thumbnail": "https://img.youtube.com/vi/CWzrABouyeE/maxresdefault.jpg"
    },
    {
      "name": "It’s a Beautiful Day — U2",
      "videoId": "co6WMzDOh1o",
      "thumbnail": "https://img.youtube.com/vi/co6WMzDOh1o/maxresdefault.jpg"
    },
    {
      "name": "Break My Stride — Matthew Wilder",
      "videoId": "48YclhI1mRo",
      "thumbnail": "https://img.youtube.com/vi/48YclhI1mRo/maxresdefault.jpg"
    },
    {
      "name": "Dream Big — Jazmine Sullivan",
      "videoId": "dOTREiW8Vck",
      "thumbnail": "https://img.youtube.com/vi/dOTREiW8Vck/maxresdefault.jpg"
    },
    {
      "name": "Shine — Take That",
      "videoId": "NJWlK2ONAlE",
      "thumbnail": "https://img.youtube.com/vi/NJWlK2ONAlE/maxresdefault.jpg"
    }
  ].obs;
  // final RxList<SongDetailed> searchYoutubeResults = <SongDetailed>[].obs;
  final RxBool isSpotifyLoading = false.obs;
  // final RxBool isYoutubeLoading = false.obs;
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
    // searchYoutubeResults.clear();
    final results = await ytmusic.searchSongs(query == '' ? 'Top' : query);
    for (final result in results) {
      // searchYoutubeResults.add(result);
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
