import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:musit/globalModels/admin_songs_model.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/song_service.dart';
import 'package:musit/services/upload_file_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../constants/app_enums.dart';
import '../../../../../globalModels/song_model.dart';
import '../../../../../services/spotify_auth_service.dart';
import '../../../../../widgets/web_view_screen.dart';
import '../../../../sendBottombar/sender_bottom_bar.dart';

class AddSongsController extends GetxController {
  final spotifyService = Get.find<SpotifyAuthService>();

  final RxInt songTypeId = 0.obs;
  final searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  ///songs list to handle selection for backend storage
  RxList<SongModel> songs = <SongModel>[].obs;

  // RxList<SongModel> librarySelected = <SongModel>[].obs;
  RxList<SongModel> adminSongs = <SongModel>[].obs;

  ///spotify list
  final RxList<Map<String, dynamic>> searchSpotifyResults =
      <Map<String, dynamic>>[].obs;

  final RxList<Map<String, dynamic>> searchInYoutubeList =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, String>> youtubeSongsList =
      <Map<String, String>>[].obs;

  // final RxList<SongDetailed> searchYoutubeResults = <SongDetailed>[].obs;
  final RxBool isSpotifyLoading = false.obs;

  final RxBool isYoutubeLoading = false.obs;
  final RxBool isAdminSongsLoading = false.obs;

  // Default fallback songs for spotify
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

    ever(spotifyService.isConnected, (connected) {
      if (connected == true) loadDefaultSpotifySongs();
    });

    // ever(ytMusicService.isConnected, (connected) {
    //   if (connected == true) loadYoutubeSongs();
    // });

    ever(
      songTypeId,
      (typeId) {
        if (typeId == 0) {
          loadDefaultSpotifySongs();
        } else if (typeId == 1) {
          loadDefaultYoutubeSongs();
        }
      },
    );

    debounce(searchQuery, (query) {
      if (songTypeId.value == 0) {
        query.toString().isEmpty
            ? loadDefaultSpotifySongs()
            : searchSpotifySong(query.toString());
      } else if (songTypeId.value == 1) {
        query.toString().isEmpty
            ? loadDefaultYoutubeSongs()
            : searchYouTube(query.toString());
      }
    }, time: const Duration(milliseconds: 600));
  }

  //load default spotify songs
  Future<void> loadDefaultSpotifySongs() async {
    if (!spotifyService.isConnected.value) return;
    await searchSpotifySong(searchQuery.value.trim().isEmpty
        ? defaultSongs.first
        : searchQuery.value);
  }

  ///search spotify songs
  Future<void> searchSpotifySong(String query) async {
    if (query.isEmpty) return loadDefaultSpotifySongs();

    isSpotifyLoading.value = true;
    try {
      final token = await spotifyService.getAccessToken();
      if (token == null) {
        // isSpotifyLoading.value = false;
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
    } catch (e) {
      debugPrint("Spotify search songs error: $e");
    } finally {
      isSpotifyLoading.value = false;
    }
  }

  //load default youtube songs
  Future<void> loadDefaultYoutubeSongs() async {
    print("********** 1");
    await searchYouTube(searchQuery.value.trim().isEmpty
        ? defaultSongs.first
        : searchQuery.value.trim());
  }

  //search youtube
  // Future<void> searchYouTube(String query) async {
  //   print("********** 2");
  //   isYoutubeLoading.value = true;
  //   try {
  //     final GoogleSignIn _googleSignIn = GoogleSignIn(
  //       scopes: [
  //         'https://www.googleapis.com/auth/youtube.readonly',
  //       ],
  //     );
  //     final GoogleSignInAccount? account = await _googleSignIn.signIn();
  //
  //     if (account == null) {
  //       print('User cancelled sign-in.');
  //       return;
  //     }
  //     final url =
  //         'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&q=<query>&key=${ApiService.youtubeApiKey}&maxResults=20';
  //     final res = await http.get(Uri.parse(url));
  //
  //     if (res.statusCode == 200) {
  //       print("********** 3");
  //       final data = jsonDecode(res.body);
  //       final items = data['items'] as List;
  //
  //       searchInYoutubeList.assignAll(items.map((item) {
  //         return {
  //           'videoId': item['id']['videoId'],
  //           'title': item['snippet']['title'],
  //           'thumbnail': item['snippet']['thumbnails']['high']['url'],
  //           'channel': item['snippet']['channelTitle'],
  //         };
  //       }).toList());
  //     } else {
  //       print("********** 4 ${res.body}");
  //       searchInYoutubeList.clear();
  //     }
  //   } catch (e) {
  //     print("********** 5");
  //     debugPrint("Youtube search songs error: $e");
  //   } finally {
  //     print("********** 6");
  //     isYoutubeLoading.value = false;
  //   }
  // }

  Future<void> searchYouTube(String query) async {
    print("********** 2");
    isYoutubeLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('youtubeAccessToken');
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['https://www.googleapis.com/auth/youtube.readonly'],
      );
      // Step 1: If no token, sign in
      if (accessToken == null) {
        final GoogleSignInAccount? account = await _googleSignIn.signIn();
        if (account == null) {
          print('User cancelled sign-in.');
          return;
        }

        final authHeaders = await account.authHeaders;
        accessToken = authHeaders['Authorization']?.split(' ').last;

        if (accessToken == null) {
          print('Failed to retrieve access token.');
          return;
        }

        // Save token in SharedPreferences
        await prefs.setString('youtubeAccessToken', accessToken);
      }

      // Step 2: Make YouTube API call with token
      final url =
          'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&q=$query&maxResults=20';

      final res = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      });

      // Step 3: Check for expired token (401) and retry
      if (res.statusCode == 401) {
        print('Access token expired, refreshing...');
        await prefs.remove('youtubeAccessToken');
        return searchYouTube(query); // retry after getting new token
      }

      if (res.statusCode == 200) {
        print("********** 3");
        final data = jsonDecode(res.body);
        final items = data['items'] as List;

        searchInYoutubeList.assignAll(items.map((item) {
          return {
            'videoId': item['id']['videoId'],
            'title': item['snippet']['title'],
            'thumbnail': item['snippet']['thumbnails']['high']['url'],
            'channel': item['snippet']['channelTitle'],
          };
        }).toList());
      } else {
        print("********** 4 ${res.body}");
        searchInYoutubeList.clear();
      }
    } catch (e) {
      print("********** 5");
      debugPrint("YouTube search songs error: $e");
    } finally {
      print("********** 6");
      isYoutubeLoading.value = false;
    }
  }

  // Future<String> getAudioStream(String videoId) async {
  //   var yt = YoutubeExplode();
  //
  //   var manifest = await yt.videos.streamsClient.getManifest(videoId);
  //   var audioStream = manifest.audioOnly.withHighestBitrate();
  //
  //   return audioStream.url.toString();
  // }

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

  Future<void> shareSong(List<SongModel> voiceRecordings,
      String? receiverPhoneNumber, List<int> selectedUsers) async {
    // Step 1: Upload voice recordings (if any)
    List<Map<AudioKey, dynamic>> voices = [];

    if (voiceRecordings.isNotEmpty) {
      for (var voice in voiceRecordings) {
        final voicePath = await UploadFileService()
            .fileUploadResult(uploadData: voice.link ?? '');

        if (voicePath != null) {
          voices
              .add({AudioKey.path: voicePath, AudioKey.name: voice.name ?? ''});
        } else {
          return;
        }
      }
    }

    // Step 2: Prepare payload for API request
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

    // Step 3: Call API to share songs
    await ApiService().handleResponse(
      apiMethod: () => SongService().shareSongs(data),
      onSuccess: (Map<String, dynamic> response) {
        // customPrint("add_songs_controller line 64: $response");

        Map<String, dynamic>? responseData = response['data'];

        // Step 4: Handle API response
        if (responseData == null) {
          Get.offAll(() => SenderBottomBar());
          customErrorSnackBar(content: response['message']);
          return;
        }

        bool paymentRequired = responseData['paymentRequired'] ?? false;
        String staus = responseData['status'] ?? '';
        String approvalLink = responseData['approvalLink'] ?? '';

        if (!paymentRequired) {
          Get.offAll(() => SenderBottomBar());
          customErrorSnackBar(content: response['message']);
        } else {
          Get.to(() => WebViewScreen(
                url: approvalLink,
                title: "Payment",
                onTap: () {
                  Get.offAll(() => SenderBottomBar());
                },
              ));
        }

        songTypeId.value = 0;
        searchController.clear();
        searchQuery.value = '';

        songs.clear();

        // RxList<SongModel> librarySelected = <SongModel>[].obs;
        adminSongs.clear();

        searchSpotifyResults.clear();

        searchInYoutubeList.clear();
      },
    );
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
/*
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
    },
    {
      "name": "Mr. Brightside — The Killers",
      "videoId": "gGdGFtwCNBE",
      "thumbnail": "https://img.youtube.com/vi/gGdGFtwCNBE/maxresdefault.jpg",
    },
    {
      "name": "Dancing Queen — ABBA",
      "videoId": "xFrGuyw1V8s",
      "thumbnail": "https://img.youtube.com/vi/xFrGuyw1V8s/maxresdefault.jpg",
    },
    {
      "name": "I Wanna Dance With Somebody (Who Loves Me) — Whitney Houston",
      "videoId": "eH3giaIzONA",
      "thumbnail": "https://img.youtube.com/vi/eH3giaIzONA/maxresdefault.jpg",
    },
    {
      "name": "Sweet Caroline — Neil Diamond",
      "videoId": "GmK5_lnQUbE",
      "thumbnail": "https://img.youtube.com/vi/GmK5_lnQUbE/maxresdefault.jpg",
    },
    {
      "name": "Murder On The Dancefloor — Sophie Ellis-Bextor",
      "videoId": "hAx6mYeC6pY",
      "thumbnail": "https://img.youtube.com/vi/hAx6mYeC6pY/maxresdefault.jpg",
    },
    {
      "name": "Dancing in the Moonlight — Toploader",
      "videoId": "0yBnIUX0QAE",
      "thumbnail": "https://img.youtube.com/vi/0yBnIUX0QAE/maxresdefault.jpg",
    },
    {
      "name": "Shut Up and Dance — WALK THE MOON",
      "videoId": "6JCLY0Rlx6Q",
      "thumbnail": "https://img.youtube.com/vi/6JCLY0Rlx6Q/maxresdefault.jpg",
    },
    {
      "name": "Livin' On A Prayer — Bon Jovi",
      "videoId": "lDK9QqIzhwk",
      "thumbnail": "https://img.youtube.com/vi/lDK9QqIzhwk/maxresdefault.jpg",
    },
    {
      "name": "Love Story — Taylor Swift",
      "videoId": "8xg3vE8Ie_E",
      "thumbnail": "https://img.youtube.com/vi/8xg3vE8Ie_E/maxresdefault.jpg",
    },
    {
      "name": "September — Earth, Wind & Fire",
      "videoId": "Gs069dndIYk",
      "thumbnail": "https://img.youtube.com/vi/Gs069dndIYk/maxresdefault.jpg",
    },
    {
      "name": "Man! I Feel Like A Woman! — Shania Twain",
      "videoId": "ZJL4UGSbeFg",
      "thumbnail": "https://img.youtube.com/vi/ZJL4UGSbeFg/maxresdefault.jpg",
    },
    {
      "name": "Come On Eileen — Dexys Midnight Runners",
      "videoId": "GbpnAGajyMc",
      "thumbnail": "https://img.youtube.com/vi/GbpnAGajyMc/maxresdefault.jpg",
    },
    {
      "name": "Summer Of '69 — Bryan Adams",
      "videoId": "eFjjO_lhf9c",
      "thumbnail": "https://img.youtube.com/vi/eFjjO_lhf9c/maxresdefault.jpg",
    },
    {
      "name": "Teenage Dirtbag — Wheatus",
      "videoId": "FC3y9llDXuM",
      "thumbnail": "https://img.youtube.com/vi/FC3y9llDXuM/maxresdefault.jpg",
    },
    {
      "name": "I Bet You Look Good On The Dancefloor — Arctic Monkeys",
      "videoId": "CYpn8yUnX_c",
      "thumbnail": "https://img.youtube.com/vi/CYpn8yUnX_c/maxresdefault.jpg",
    },
    {
      "name": "Sex On Fire — Kings Of Leon",
      "videoId": "RF0HhrwIwp0",
      "thumbnail": "https://img.youtube.com/vi/RF0HhrwIwp0/maxresdefault.jpg",
    },
    {
      "name": "Proud Mary — Creedence Clearwater Revival",
      "videoId": "7F_ILRVJdes",
      "thumbnail": "https://img.youtube.com/vi/7F_ILRVJdes/maxresdefault.jpg",
    },
    {
      "name": "Crazy In Love — Beyoncé ft. JAY-Z",
      "videoId": "ViwtNLUqkMY",
      "thumbnail": "https://img.youtube.com/vi/ViwtNLUqkMY/maxresdefault.jpg",
    },
    {
      "name": "Freed From Desire — Gala",
      "videoId": "npTJcTZSwdE",
      "thumbnail": "https://img.youtube.com/vi/npTJcTZSwdE/maxresdefault.jpg",
    },
    {
      "name": "Uptown Funk — Mark Ronson ft. Bruno Mars",
      "videoId": "OPf0YbXqDm0",
      "thumbnail": "https://img.youtube.com/vi/OPf0YbXqDm0/maxresdefault.jpg",
    },
    {
      "name": "Unwritten — Natasha Bedingfield",
      "videoId": "b7k0a5hYnSI",
      "thumbnail": "https://img.youtube.com/vi/b7k0a5hYnSI/maxresdefault.jpg",
    },
    {
      "name": "Gimme! Gimme! Gimme! (A Man After Midnight) — ABBA",
      "videoId": "XEjLoHdbVeE",
      "thumbnail": "https://img.youtube.com/vi/XEjLoHdbVeE/maxresdefault.jpg",
    },
    {
      "name": "I Gotta Feeling — Black Eyed Peas",
      "videoId": "uSD4vsh1zDA",
      "thumbnail": "https://img.youtube.com/vi/uSD4vsh1zDA/maxresdefault.jpg",
    },
    {
      "name": "Temperature — Sean Paul",
      "videoId": "dW2MmuA1nI4",
      "thumbnail": "https://img.youtube.com/vi/dW2MmuA1nI4/maxresdefault.jpg",
    },
    {
      "name": "Don’t Stop Me Now — Queen",
      "videoId": "HgzGwKwLmgM",
      "thumbnail": "https://img.youtube.com/vi/HgzGwKwLmgM/maxresdefault.jpg",
    },
    {
      "name": "We Found Love — Rihanna ft. Calvin Harris",
      "videoId": "tg00YEETFzg",
      "thumbnail": "https://img.youtube.com/vi/tg00YEETFzg/maxresdefault.jpg",
    },
    {
      "name": "Wonderwall — Oasis",
      "videoId": "bx1Bh8ZvH84",
      "thumbnail": "https://img.youtube.com/vi/bx1Bh8ZvH84/maxresdefault.jpg",
    },
    {
      "name": "Don’t Stop Believin’ — Journey",
      "videoId": "oZHJP14BVRs",
      "thumbnail": "https://img.youtube.com/vi/oZHJP14BVRs/maxresdefault.jpg",
    },
    {
      "name": "Wannabe — Spice Girls",
      "videoId": "gJLIiF15wjQ",
      "thumbnail": "https://img.youtube.com/vi/gJLIiF15wjQ/maxresdefault.jpg",
    },
    {
      "name": "Show Me Love — Robin S",
      "videoId": "Ps2Jc28tQrw",
      "thumbnail": "https://img.youtube.com/vi/Ps2Jc28tQrw/maxresdefault.jpg",
    },
    {
      "name": "Cha Cha Slide — DJ Casper",
      "videoId": "YIhBFtwCNBE",
      "thumbnail": "https://img.youtube.com/vi/YIhBFtwCNBE/maxresdefault.jpg",
    },
    {
      "name": "Mamma Mia — ABBA",
      "videoId": "unfzfe8f9NI",
      "thumbnail": "https://img.youtube.com/vi/unfzfe8f9NI/maxresdefault.jpg",
    },
    {
      "name": "Girls Just Want To Have Fun — Cyndi Lauper",
      "videoId": "PIb6AZdTr-A",
      "thumbnail": "https://img.youtube.com/vi/PIb6AZdTr-A/maxresdefault.jpg",
    },
    {
      "name": "Forever — Chris Brown",
      "videoId": "5sMKX22BHeE",
      "thumbnail": "https://img.youtube.com/vi/5sMKX22BHeE/maxresdefault.jpg",
    },
    {
      "name": "Hey Ya! — OutKast",
      "videoId": "PWgvGjAhvIw",
      "thumbnail": "https://img.youtube.com/vi/PWgvGjAhvIw/maxresdefault.jpg",
    },
    {
      "name": "Young Hearts Run Free — Candi Staton",
      "videoId": "wddgskIRVeg",
      "thumbnail": "https://img.youtube.com/vi/wddgskIRVeg/maxresdefault.jpg",
    },
    {
      "name": "Yeah! — Usher ft. Lil Jon & Ludacris",
      "videoId": "GxBSyx85Kp8",
      "thumbnail": "https://img.youtube.com/vi/GxBSyx85Kp8/maxresdefault.jpg",
    },
    {
      "name": "Shake It Off — Taylor Swift",
      "videoId": "nfWlot6h_JM",
      "thumbnail": "https://img.youtube.com/vi/nfWlot6h_JM/maxresdefault.jpg",
    },
    {
      "name": "Valerie — Mark Ronson ft. Amy Winehouse",
      "videoId": "bixuI_GV5I0",
      "thumbnail": "https://img.youtube.com/vi/bixuI_GV5I0/maxresdefault.jpg",
    },
    {
      "name": "Believe — Cher",
      "videoId": "nZXRV4MezEw",
      "thumbnail": "https://img.youtube.com/vi/nZXRV4MezEw/maxresdefault.jpg",
    },
    {
      "name": "All The Small Things — Blink‑182",
      "videoId": "9Ht5RZpzPqw",
      "thumbnail": "https://img.youtube.com/vi/9Ht5RZpzPqw/maxresdefault.jpg",
    },
    {
      "name": "Macarena (Bayside Boys Remix) — Los Del Río",
      "videoId": "zWaymcVmJ‑A",
      "thumbnail": "https://img.youtube.com/vi/zWaymcVmJ‑A/maxresdefault.jpg",
    },
    {
      "name": "Chelsea Dagger — The Fratellis",
      "videoId": "sEXHeTcxQy4",
      "thumbnail": "https://img.youtube.com/vi/sEXHeTcxQy4/maxresdefault.jpg",
    },
    {
      "name": "Low — Flo Rida feat. T‑Pain",
      "videoId": "U2waT9TxPU0",
      "thumbnail": "https://img.youtube.com/vi/U2waT9TxPU0/maxresdefault.jpg",
    },
    {
      "name": "Marry You — Bruno Mars",
      "videoId": "dElRVQFqj‑k",
      "thumbnail": "https://img.youtube.com/vi/dElRVQFqj‑k/maxresdefault.jpg",
    },
    {
      "name": "Never Gonna Give You Up — Rick Astley",
      "videoId": "dQw4w9WgXcQ",
      "thumbnail": "https://img.youtube.com/vi/dQw4w9WgXcQ/maxresdefault.jpg",
    },
    {
      "name": "Never Too Much — Luther Vandross",
      "videoId": "pNj9bXKGOiI",
      "thumbnail": "https://img.youtube.com/vi/pNj9bXKGOiI/maxresdefault.jpg",
    },
    {
      "name": "Reach — S Club",
      "videoId": "50kP4S0peAs",
      "thumbnail": "https://img.youtube.com/vi/50kP4S0peAs/maxresdefault.jpg",
    },
    {
      "name": "Everytime We Touch — Cascada",
      "videoId": "4G6QDNC4jPs",
      "thumbnail": "https://img.youtube.com/vi/4G6QDNC4jPs/maxresdefault.jpg",
    },
    {
      "name": "Wake Me Up Before You Go‑Go — Wham!",
      "videoId": "pIgZ7gMze7A",
      "thumbnail": "https://img.youtube.com/vi/pIgZ7gMze7A/maxresdefault.jpg",
    },
    {
      "name": "Sweet Child O’ Mine — Guns N' Roses",
      "videoId": "1w7OgIMMRc4",
      "thumbnail": "https://img.youtube.com/vi/1w7OgIMMRc4/maxresdefault.jpg",
    },
    {
      "name": "A Sky Full Of Stars — Coldplay",
      "videoId": "VPRjCeoBqrI",
      "thumbnail": "https://img.youtube.com/vi/VPRjCeoBqrI/maxresdefault.jpg",
    },
    {
      "name": "A Little Respect — Erasure",
      "videoId": "x34icYC8zA0",
      "thumbnail": "https://img.youtube.com/vi/x34icYC8zA0/maxresdefault.jpg",
    },
    {
      "name": "Mambo No. 5 (A Little Bit Of…) — Lou Bega",
      "videoId": "EK_LN3XEcnw",
      "thumbnail": "https://img.youtube.com/vi/EK_LN3XEcnw/maxresdefault.jpg",
    },
    {
      "name": "Footloose — Kenny Loggins",
      "videoId": "ltrMfT4Qz5Y",
      "thumbnail": "https://img.youtube.com/vi/ltrMfT4Qz5Y/maxresdefault.jpg",
    },
    {
      "name": "(I've Had The) Time Of My Life — Bill Medley & Jennifer Warnes",
      "videoId": "KCkgYhtz64U",
      "thumbnail": "https://img.youtube.com/vi/KCkgYhtz64U/maxresdefault.jpg",
    },
    {
      "name": "I'm Still Standing — Elton John",
      "videoId": "ZHwVBirqD2s",
      "thumbnail": "https://img.youtube.com/vi/ZHwVBirqD2s/maxresdefault.jpg",
    },
    {
      "name": "Y.M.C.A. — Village People",
      "videoId": "CS9OO0S5w2k",
      "thumbnail": "https://img.youtube.com/vi/CS9OO0S5w2k/maxresdefault.jpg",
    },
    {
      "name": "Bohemian Rhapsody — Queen",
      "videoId": "fJ9rUzIMcZQ",
      "thumbnail": "https://img.youtube.com/vi/fJ9rUzIMcZQ/maxresdefault.jpg",
    },
    {
      "name": "Everybody (Backstreet's Back) — Backstreet Boys",
      "videoId": "6M9Xy0pN-6g",
      "thumbnail": "https://img.youtube.com/vi/6M9Xy0pN-6g/maxresdefault.jpg",
    },
    {
      "name": "Love Shack — B‑52's",
      "videoId": "9SOryJvTAGs",
      "thumbnail": "https://img.youtube.com/vi/9SOryJvTAGs/maxresdefault.jpg",
    },
    {
      "name": "Rhythm Is A Dancer — Snap!",
      "videoId": "f3KOmznlS‑Q",
      "thumbnail": "https://img.youtube.com/vi/f3KOmznlS‑Q/maxresdefault.jpg",
    },
    {
      "name": "Brown Eyed Girl — Van Morrison",
      "videoId": "UfmkgQRmmeE",
      "thumbnail": "https://img.youtube.com/vi/UfmkgQRmmeE/maxresdefault.jpg",
    },
    {
      "name": "Cotton Eye Joe — Rednex",
      "videoId": "mOYZaiDZ7BM",
      "thumbnail": "https://img.youtube.com/vi/mOYZaiDZ7BM/maxresdefault.jpg",
    },
    {
      "name": "The Best — Tina Turner",
      "videoId": "GC5E8ie2pdM",
      "thumbnail": "https://img.youtube.com/vi/GC5E8ie2pdM/maxresdefault.jpg",
    },
    {
      "name": "Hips Don’t Lie — Shakira",
      "videoId": "cfRIiwyUA0U",
      "thumbnail": "https://img.youtube.com/vi/cfRIiwyUA0U/maxresdefault.jpg",
    },
    {
      "name": "9 To 5 — Dolly Parton",
      "videoId": "UbxUSsFXYo4",
      "thumbnail": "https://img.youtube.com/vi/UbxUSsFXYo4/maxresdefault.jpg",
    },
    {
      "name": "C’est La Vie — B*Witched",
      "videoId": "q8drfeW0Chs",
      "thumbnail": "https://img.youtube.com/vi/q8drfeW0Chs/maxresdefault.jpg",
    },
    {
      "name": "Rock DJ — Robbie Williams",
      "videoId": "BnO3nijfYmU",
      "thumbnail": "https://img.youtube.com/vi/BnO3nijfYmU/maxresdefault.jpg",
    },
    {
      "name": "You’ve Got The Love — Florence + The Machine",
      "videoId": "PQZhN65vq9E",
      "thumbnail": "https://img.youtube.com/vi/PQZhN65vq9E/maxresdefault.jpg",
    },
    {
      "name": "Don’t Look Back In Anger — Oasis",
      "videoId": "r8OipmKFDeM",
      "thumbnail": "https://img.youtube.com/vi/r8OipmKFDeM/maxresdefault.jpg",
    },
    {
      "name": "Flowers — Sweet Female Attitude",
      "videoId": "iR2tIyj8_y8",
      "thumbnail": "https://img.youtube.com/vi/iR2tIyj8_y8/maxresdefault.jpg",
    },
    {
      "name": "Raise Your Glass — Pink",
      "videoId": "XjVNlG5cZyQ",
      "thumbnail": "https://img.youtube.com/vi/XjVNlG5cZyQ/maxresdefault.jpg",
    },
    {
      "name": "Party In The U.S.A. — Miley Cyrus",
      "videoId": "M11SvDtPBhA",
      "thumbnail": "https://img.youtube.com/vi/M11SvDtPBhA/maxresdefault.jpg",
    },
    {
      "name": "Get Busy — Sean Paul",
      "videoId": "oPQ3o14ksaM",
      "thumbnail": "https://img.youtube.com/vi/oPQ3o14ksaM/maxresdefault.jpg",
    },
    {
      "name": "Blame It On The Boogie — The Jacksons",
      "videoId": "nqxVMLVe62U",
      "thumbnail": "https://img.youtube.com/vi/nqxVMLVe62U/maxresdefault.jpg",
    },
    {
      "name": "Jump Around — House Of Pain",
      "videoId": "XhzpxjuwZy0",
      "thumbnail": "https://img.youtube.com/vi/XhzpxjuwZy0/maxresdefault.jpg",
    },
    {
      "name": "How Will I Know — Whitney Houston",
      "videoId": "d9sf4SE4wJE",
      "thumbnail": "https://img.youtube.com/vi/d9sf4SE4wJE/maxresdefault.jpg",
    },
    {
      "name": "5, 6, 7, 8 — Steps",
      "videoId": "4NO-h9PFum4",
      "thumbnail": "https://img.youtube.com/vi/4NO-h9PFum4/maxresdefault.jpg",
    },
    {
      "name": "We Are Family — Sister Sledge",
      "videoId": "bD1qs5Uhk6g",
      "thumbnail": "https://img.youtube.com/vi/bD1qs5Uhk6g/maxresdefault.jpg",
    },
    {
      "name": "Blinding Lights — The Weeknd",
      "videoId": "4NRXx6U8ABQ",
      "thumbnail": "https://img.youtube.com/vi/4NRXx6U8ABQ/maxresdefault.jpg",
    },
    {
      "name": "No Scrubs — TLC",
      "videoId": "FrLequ6dUdM",
      "thumbnail": "https://img.youtube.com/vi/FrLequ6dUdM/maxresdefault.jpg",
    },
    {
      "name": "Build Me Up Buttercup — The Foundations",
      "videoId": "klNean7JJdA",
      "thumbnail": "https://img.youtube.com/vi/klNean7JJdA/maxresdefault.jpg",
    },
    {
      "name": "All Night Long — Lionel Richie",
      "videoId": "nqAvFx3NxUM",
      "thumbnail": "https://img.youtube.com/vi/nqAvFx3NxUM/maxresdefault.jpg",
    },
    {
      "name": "Waterloo — ABBA",
      "videoId": "Sj_9CiNkkn4",
      "thumbnail": "https://img.youtube.com/vi/Sj_9CiNkkn4/maxresdefault.jpg",
    },
    {
      "name": "Take On Me — A‑Ha",
      "videoId": "djV11Xbc914",
      "thumbnail": "https://img.youtube.com/vi/djV11Xbc914/maxresdefault.jpg",
    },
    {
      "name": "Candy — Robbie Williams",
      "videoId": "HqM7g4jH5Hk",
      "thumbnail": "https://img.youtube.com/vi/HqM7g4jH5Hk/maxresdefault.jpg",
    },
    {
      "name": "Boom, Boom, Boom, Boom!! — Vengaboys",
      "videoId": "llyiQ4I-mQ",
      "thumbnail": "https://img.youtube.com/vi/llyiQ4I-mQ/maxresdefault.jpg",
    },
    {
      "name": "All Star — Smash Mouth",
      "videoId": "L_jWHffIx5E",
      "thumbnail": "https://img.youtube.com/vi/L_jWHffIx5E/maxresdefault.jpg",
    },
    {
      "name": "Uptown Girl — Billy Joel",
      "videoId": "hCuMWrfXG4E",
      "thumbnail": "https://img.youtube.com/vi/hCuMWrfXG4E/maxresdefault.jpg",
    },
    {
      "name": "Grease Megamix — John Travolta & Olivia Newton‑John",
      "videoId": "WTAg7aolyCY",
      "thumbnail": "https://img.youtube.com/vi/WTAg7aolyCY/maxresdefault.jpg",
    },
    {
      "name": "Single Ladies (Put a Ring on It) — Beyoncé",
      "videoId": "4m1EFMoRFvY",
      "thumbnail": "https://img.youtube.com/vi/4m1EFMoRFvY/maxresdefault.jpg",
    },
    {
      "name": "I’m Gonna Be (500 Miles) — The Proclaimers",
      "videoId": "oUv0NbjbGzQ",
      "thumbnail": "https://img.youtube.com/vi/oUv0NbjbGzQ/maxresdefault.jpg",
    },
    {
      "name": "She’s So Lovely — Scouting For Girls",
      "videoId": "7ABNEjPxWEg",
      "thumbnail": "https://img.youtube.com/vi/7ABNEjPxWEg/maxresdefault.jpg",
    },
    {
      "name": "Saturday Night — Bay City Rollers",
      "videoId": "7BKKaKT_dtM",
      "thumbnail": "https://img.youtube.com/vi/7BKKaKT_dtM/maxresdefault.jpg",
    },
    {
      "name": "A Bar Song (Tipsy) — Shaboozey",
      "videoId": "t7bQwwqW‑HcU",
      "thumbnail": "https://img.youtube.com/vi/t7bQwwqW‑HcU/maxresdefault.jpg",
    },
    {
      "name": "Crashed The Wedding — Busted",
      "videoId": "QclbaDc_Kdc",
      "thumbnail": "https://img.youtube.com/vi/QclbaDc_Kdc/maxresdefault.jpg",
    },
    {
      "name": "Give Me Everything — Pitbull ft. Ne‑Yo, Afrojack & Nayer",
      "videoId": "EPo5wWmKEaI",
      "thumbnail": "https://img.youtube.com/vi/EPo5wWmKEaI/maxresdefault.jpg",
    },
    {
      "name": "Love On Top — Beyoncé",
      "videoId": "Ob7vObnFUJc",
      "thumbnail": "https://img.youtube.com/vi/Ob7vObnFUJc/maxresdefault.jpg",
    },
    {
      "name": "Year 3000 — Jonas Brothers",
      "videoId": "OUKF90zNRcU",
      "thumbnail": "https://img.youtube.com/vi/OUKF90zNRcU/maxresdefault.jpg",
    },
    {
      "name": "Pretty Green Eyes — Ultrabeat",
      "videoId": "E48JhG2bMQ4",
      "thumbnail": "https://img.youtube.com/vi/E48JhG2bMQ4/maxresdefault.jpg",
    },
    {
      "name": "I Believe In A Thing Called Love — The Darkness",
      "videoId": "Vf_6e9N8CNo",
      "thumbnail": "https://img.youtube.com/vi/Vf_6e9N8CNo/maxresdefault.jpg",
    },
    {
      "name": "Rasputin — Majestic & Boney M.",
      "videoId": "cZwYpAh3bXQ",
      "thumbnail": "https://img.youtube.com/vi/cZwYpAh3bXQ/maxresdefault.jpg",
    },
    {
      "name": "What Makes You Beautiful — One Direction",
      "videoId": "QJO3ROT-A4E",
      "thumbnail": "https://img.youtube.com/vi/QJO3ROT-A4E/maxresdefault.jpg",
    },
    {
      "name": "Timber — Pitbull ft. Kesha",
      "videoId": "hHUbLv4ThOo",
      "thumbnail": "https://img.youtube.com/vi/hHUbLv4ThOo/maxresdefault.jpg",
    },
    {
      "name": "Twist And Shout — Beatles",
      "videoId": "oLIYPdZeYeU",
      "thumbnail": "https://img.youtube.com/vi/oLIYPdZeYeU/maxresdefault.jpg",
    },
    {
      "name": "Africa — Toto",
      "videoId": "FTQbiNvZqaY",
      "thumbnail": "https://img.youtube.com/vi/FTQbiNvZqaY/maxresdefault.jpg",
    },
    {
      "name": "Not Nineteen Forever — The Courteeners",
      "videoId": "Qw8M_c0fLkA",
      "thumbnail": "https://img.youtube.com/vi/Qw8M_c0fLkA/maxresdefault.jpg",
    },
    {
      "name": "Signed, Sealed, Delivered (I'm Yours) — Stevie Wonder",
      "videoId": "6To0fvX_wFA",
      "thumbnail": "https://img.youtube.com/vi/6To0fvX_wFA/maxresdefault.jpg",
    },
    {
      "name": "Perfect — Ed Sheeran",
      "videoId": "2Vv‑BfVoq4g",
      "thumbnail": "https://img.youtube.com/vi/2Vv‑BfVoq4g/maxresdefault.jpg",
    },
    {
      "name": "Gold Digger — Kanye West",
      "videoId": "6vwNcNOTVzY",
      "thumbnail": "https://img.youtube.com/vi/6vwNcNOTVzY/maxresdefault.jpg",
    },
    {
      "name": "Dancing In The Dark — Bruce Springsteen",
      "videoId": "129kuDCQtHs",
      "thumbnail": "https://img.youtube.com/vi/129kuDCQtHs/maxresdefault.jpg",
    },
    {
      "name": "Angels — David Archuleta",
      "videoId": "PiZwiUCv9Cw",
      "thumbnail": "https://img.youtube.com/vi/PiZwiUCv9Cw/maxresdefault.jpg",
    },
    {
      "name": "It’s Raining Men — Weather Girls",
      "videoId": "ZvCIgjUn58M",
      "thumbnail": "https://img.youtube.com/vi/ZvCIgjUn58M/maxresdefault.jpg",
    },
    {
      "name": "Wake Me Up! — Avicii",
      "videoId": "IcrbM1l_BoI",
      "thumbnail": "https://img.youtube.com/vi/IcrbM1l_BoI/maxresdefault.jpg",
    },
    {
      "name": "American Boy — Estelle",
      "videoId": "HSkyD7lWxkY",
      "thumbnail": "https://img.youtube.com/vi/HSkyD7lWxkY/maxresdefault.jpg",
    },
    {
      "name": "One Kiss — Calvin Harris and Dua Lipa",
      "videoId": "DkeiKbqa02g",
      "thumbnail": "https://img.youtube.com/vi/DkeiKbqa02g/maxresdefault.jpg",
    },
    {
      "name": "Crazy Little Thing Called Love — Queen",
      "videoId": "zO6D_BAuYCI",
      "thumbnail": "https://img.youtube.com/vi/zO6D_BAuYCI/maxresdefault.jpg",
    },
    {
      "name": "Party Rock Anthem — LMFAO",
      "videoId": "KQ6zr6kCPj8",
      "thumbnail": "https://img.youtube.com/vi/KQ6zr6kCPj8/maxresdefault.jpg",
    },
    {
      "name": "Don’t You Worry Child — Swedish House Mafia",
      "videoId": "3mWbRB3Y4R8",
      "thumbnail": "https://img.youtube.com/vi/3mWbRB3Y4R8/maxresdefault.jpg",
    },
    {
      "name": "Red Red Wine — UB40",
      "videoId": "zXt56MB-3vc",
      "thumbnail": "https://img.youtube.com/vi/zXt56MB-3vc/maxresdefault.jpg",
    },
    {
      "name": "Shotgun — George Ezra",
      "videoId": "aAiVsqfbn5g",
      "thumbnail": "https://img.youtube.com/vi/aAiVsqfbn5g/maxresdefault.jpg",
    },
    {
      "name": "Go Your Own Way — Fleetwood Mac",
      "videoId": "ozl3L9fhKtE",
      "thumbnail": "https://img.youtube.com/vi/ozl3L9fhKtE/maxresdefault.jpg",
    },
    {
      "name": "Despacito — Luis Fonsi feat. Daddy Yankee",
      "videoId": "kJQP7kiw5Fk",
      "thumbnail": "https://img.youtube.com/vi/kJQP7kiw5Fk/maxresdefault.jpg",
    },
    {
      "name": "Insomnia — Faithless",
      "videoId": "P8JEm4d6Wu4",
      "thumbnail": "https://img.youtube.com/vi/P8JEm4d6Wu4/maxresdefault.jpg",
    },
    {
      "name": "Levels — Avicii",
      "videoId": "wDuoOapZ9Z0",
      "thumbnail": "https://img.youtube.com/vi/wDuoOapZ9Z0/maxresdefault.jpg",
    },
    {
      "name": "Billie Jean — Michael Jackson",
      "videoId": "Zi_XLOBDo_Y",
      "thumbnail": "https://img.youtube.com/vi/Zi_XLOBDo_Y/maxresdefault.jpg",
    },
    {
      "name": "One More Time — Daft Punk",
      "videoId": "FGBhQbmPwH8",
      "thumbnail": "https://img.youtube.com/vi/FGBhQbmPwH8/maxresdefault.jpg",
    },
    {
      "name": "Boogie Wonderland — Earth, Wind & Fire",
      "videoId": "god7hAPv8f0",
      "thumbnail": "https://img.youtube.com/vi/god7hAPv8f0/maxresdefault.jpg",
    },
    {
      "name": "Everywhere — Michelle Branch",
      "videoId": "oIwDPhNE97M",
      "thumbnail": "https://img.youtube.com/vi/oIwDPhNE97M/maxresdefault.jpg",
    },
    {
      "name": "Red Light Spells Danger — Billy Ocean",
      "videoId": "dW66keO8Iew",
      "thumbnail": "https://img.youtube.com/vi/dW66keO8Iew/maxresdefault.jpg",
    },
    {
      "name": "Champagne Supernova — Oasis",
      "videoId": "tI-5uv4wryI",
      "thumbnail": "https://img.youtube.com/vi/tI-5uv4wryI/maxresdefault.jpg",
    },
    {
      "name": "Starships — Nicki Minaj",
      "videoId": "SeIJmciN8mo",
      "thumbnail": "https://img.youtube.com/vi/SeIJmciN8mo/maxresdefault.jpg",
    },
    {
      "name": "Fireball — Pitbull",
      "videoId": "HMqgVXSvwGo",
      "thumbnail": "https://img.youtube.com/vi/HMqgVXSvwGo/maxresdefault.jpg",
    },
    {
      "name": "Spice Up Your Life — Spice Girls",
      "videoId": "9wfpXI5PKlw",
      "thumbnail": "https://img.youtube.com/vi/9wfpXI5PKlw/maxresdefault.jpg",
    },
    {
      "name": "Livin' La Vida Loca — Ricky Martin",
      "videoId": "p47fEXGabaY",
      "thumbnail": "https://img.youtube.com/vi/p47fEXGabaY/maxresdefault.jpg",
    },
    {
      "name": "I Want It That Way — Backstreet Boys",
      "videoId": "4fndeDfaWCg",
      "thumbnail": "https://img.youtube.com/vi/4fndeDfaWCg/maxresdefault.jpg",
    },
    {
      "name": "Happy — Pharrell Williams",
      "videoId": "ZbZSe6N_BXs",
      "thumbnail": "https://img.youtube.com/vi/ZbZSe6N_BXs/maxresdefault.jpg",
    },
    {
      "name": "Walking On Sunshine — Katrina & The Waves",
      "videoId": "iPUmE-tne5U",
      "thumbnail": "https://img.youtube.com/vi/iPUmE-tne5U/maxresdefault.jpg",
    },
    {
      "name": "Superstition — Stevie Wonder",
      "videoId": "ftdZ363R9kQ",
      "thumbnail": "https://img.youtube.com/vi/ftdZ363R9kQ/maxresdefault.jpg",
    },
    {
      "name": "Set You Free — Black Keys",
      "videoId": "IhwrdRh-K68",
      "thumbnail": "https://img.youtube.com/vi/IhwrdRh-K68/maxresdefault.jpg",
    },
    {
      "name": "Can’t Help Falling In Love — Elvis Presley",
      "videoId": "vGJTaP6anOU",
      "thumbnail": "https://img.youtube.com/vi/vGJTaP6anOU/maxresdefault.jpg",
    },
    {
      "name": "My Girl — Temptations",
      "videoId": "eepLY8J4E6c",
      "thumbnail": "https://img.youtube.com/vi/eepLY8J4E6c/maxresdefault.jpg",
    },
    {
      "name": "Celebration — Kool & The Gang",
      "videoId": "hSZhvMMG9d8",
      "thumbnail": "https://img.youtube.com/vi/hSZhvMMG9d8/maxresdefault.jpg",
    },
    {
      "name": "Ain’t No Mountain High Enough — Diana Ross / Marvin Gaye",
      "videoId": "ABfQuZqq8wg",
      "thumbnail": "https://img.youtube.com/vi/ABfQuZqq8wg/maxresdefault.jpg",
    },
    {
      "name": "Tainted Love — Soft Cell",
      "videoId": "XZVpR3Pk-r8",
      "thumbnail": "https://img.youtube.com/vi/XZVpR3Pk-r8/maxresdefault.jpg",
    },
    {
      "name": "Mr. Blue Sky — Electric Light Orchestra",
      "videoId": "aQUlA8Hcv4s",
      "thumbnail": "https://img.youtube.com/vi/aQUlA8Hcv4s/maxresdefault.jpg",
    },
    {
      "name": "Can’t Stop The Feeling! — Justin Timberlake",
      "videoId": "KxKV_E-wB10",
      "thumbnail": "https://img.youtube.com/vi/KxKV_E-wB10/maxresdefault.jpg",
    },
    {
      "name": "Moves Like Jagger — Maroon 5 ft. Christina Aguilera",
      "videoId": "iEPTlhBmwRg",
      "thumbnail": "https://img.youtube.com/vi/iEPTlhBmwRg/maxresdefault.jpg",
    },
    {
      "name": "One Dance — Drake",
      "videoId": "wHQSGPq5v2o",
      "thumbnail": "https://img.youtube.com/vi/wHQSGPq5v2o/maxresdefault.jpg",
    },
    {
      "name": "Take A Chance On Me — ABBA",
      "videoId": "-crgQGdpZR0",
      "thumbnail": "https://img.youtube.com/vi/-crgQGdpZR0/maxresdefault.jpg",
    },
    {
      "name": "Stayin' Alive — Bee Gees",
      "videoId": "I_izvAbhExY",
      "thumbnail": "https://img.youtube.com/vi/I_izvAbhExY/maxresdefault.jpg",
    },
    {
      "name": "Higher Love — Kygo & Whitney Houston",
      "videoId": "JR49dyo‑y0E",
      "thumbnail": "https://img.youtube.com/vi/JR49dyo‑y0E/maxresdefault.jpg",
    },
    {
      "name": "You Can't Hurry Love — The Supremes",
      "videoId": "Zi7KEmI3Mdo",
      "thumbnail": "https://img.youtube.com/vi/Zi7KEmI3Mdo/maxresdefault.jpg",
    },
    {
      "name": "You Make Me Feel — Cobra Starship feat. Sabi",
      "videoId": "HpyZEzrDf4c",
      "thumbnail": "https://img.youtube.com/vi/HpyZEzrDf4c/maxresdefault.jpg",
    },
    {
      "name": "Dance With Me Tonight — Olly Murs",
      "videoId": "F3EG4olrFjY",
      "thumbnail": "https://img.youtube.com/vi/F3EG4olrFjY/maxresdefault.jpg",
    },
    {
      "name": "Dreams — The Game",
      "videoId": "2K0q74jtV8s",
      "thumbnail": "https://img.youtube.com/vi/2K0q74jtV8s/maxresdefault.jpg",
    },
    {
      "name": "Let’s Dance — David Bowie",
      "videoId": "V53YJ9j7F3g",
      "thumbnail": "https://img.youtube.com/vi/V53YJ9j7F3g/maxresdefault.jpg",
    },
    {
      "name": "Turn Me On — David Guetta ft. Nicki Minaj",
      "videoId": "YVw7eJ0vGfM",
      "thumbnail": "https://img.youtube.com/vi/YVw7eJ0vGfM/maxresdefault.jpg",
    },
    {
      "name": "Titanium — David Guetta ft. Sia",
      "videoId": "JRfuAukYTKg",
      "thumbnail": "https://img.youtube.com/vi/JRfuAukYTKg/maxresdefault.jpg",
    },
    {
      "name": "Stick Season — Noah Kahan",
      "videoId": "JKrDdsgXuso",
      "thumbnail": "https://img.youtube.com/vi/JKrDdsgXuso/maxresdefault.jpg",
    },
    {
      "name": "Iris — Goo Goo Dolls",
      "videoId": "NdYWuo9OFAw",
      "thumbnail": "https://img.youtube.com/vi/NdYWuo9OFAw/maxresdefault.jpg",
    },
    {
      "name": "Never Forget — Take That",
      "videoId": "OR2-zwVoo2M",
      "thumbnail": "https://img.youtube.com/vi/OR2-zwVoo2M/maxresdefault.jpg",
    },
    {
      "name": "Can’t Hold Us — Macklemore & Ryan Lewis",
      "videoId": "2zNSgSzhBfM",
      "thumbnail": "https://img.youtube.com/vi/2zNSgSzhBfM/maxresdefault.jpg",
    },
    {
      "name": "Bad Habits — Ed Sheeran",
      "videoId": "orJSJGHjBLI",
      "thumbnail": "https://img.youtube.com/vi/orJSJGHjBLI/maxresdefault.jpg",
    },
    {
      "name": "Ignition (Remix) — R. Kelly",
      "videoId": "j4JBrd-xAc0",
      "thumbnail": "https://img.youtube.com/vi/j4JBrd-xAc0/maxresdefault.jpg",
    },
    {
      "name": "Watermelon Sugar — Harry Styles",
      "videoId": "E07s5ZYygMg",
      "thumbnail": "https://img.youtube.com/vi/E07s5ZYygMg/maxresdefault.jpg",
    },
    {
      "name": "Time Warp — Rocky Horror Picture Show Cast",
      "videoId": "S91wQbYYX3Q",
      "thumbnail": "https://img.youtube.com/vi/S91wQbYYX3Q/maxresdefault.jpg",
    },
    {
      "name": "Don't You Want Me — Jody Watley",
      "videoId": "gJwXg4VSzAI",
      "thumbnail": "https://img.youtube.com/vi/gJwXg4VSzAI/maxresdefault.jpg",
    },
    {
      "name": "Don't Stop ‘Til You Get Enough — Michael Jackson",
      "videoId": "2Vf6JIH2zFI",
      "thumbnail": "https://img.youtube.com/vi/2Vf6JIH2zFI/maxresdefault.jpg",
    },
    {
      "name": "Take A Chance On Me — ABBA",
      "videoId": "-crgQGdpZR0",
      "thumbnail": "https://img.youtube.com/vi/-crgQGdpZR0/maxresdefault.jpg",
    },
    {
      "name": "Stayin' Alive — Bee Gees",
      "videoId": "I_izvAbhExY",
      "thumbnail": "https://img.youtube.com/vi/I_izvAbhExY/maxresdefault.jpg",
    },
    {
      "name": "Higher Love — Kygo & Whitney Houston",
      "videoId": "JR49dyo‑y0E",
      "thumbnail": "https://img.youtube.com/vi/JR49dyo‑y0E/maxresdefault.jpg",
    },
    {
      "name": "You Can't Hurry Love — The Supremes",
      "videoId": "Zi7KEmI3Mdo",
      "thumbnail": "https://img.youtube.com/vi/Zi7KEmI3Mdo/maxresdefault.jpg",
    },
    {
      "name": "You Make Me Feel — Cobra Starship feat. Sabi",
      "videoId": "HpyZEzrDf4c",
      "thumbnail": "https://img.youtube.com/vi/HpyZEzrDf4c/maxresdefault.jpg",
    },
    {
      "name": "Still Into You — Paramore",
      "videoId": "gl1aHhXnN1k",
      "thumbnail": "https://img.youtube.com/vi/gl1aHhXnN1k/maxresdefault.jpg",
    },
    {
      "name": "Viva La Vida — Coldplay",
      "videoId": "dvgZkm1xWPE",
      "thumbnail": "https://img.youtube.com/vi/dvgZkm1xWPE/maxresdefault.jpg",
    },
    {
      "name": "Heaven — Los Lonely Boys",
      "videoId": "45-S_nPCl5o",
      "thumbnail": "https://img.youtube.com/vi/45-S_nPCl5o/maxresdefault.jpg",
    },
    {
      "name": "You Make My Dreams (Come True) — Daryl Hall & John Oates",
      "videoId": "6O0kIAdL4i0",
      "thumbnail": "https://img.youtube.com/vi/6O0kIAdL4i0/maxresdefault.jpg",
    },
    {
      "name": "Espresso — Sabrina Carpenter",
      "videoId": "D4yptTLWPR0",
      "thumbnail": "https://img.youtube.com/vi/D4yptTLWPR0/maxresdefault.jpg",
    },
    {
      "name": "Beautiful Things — Benson Boone",
      "videoId": "Oa_RSwwpPaA",
      "thumbnail": "https://img.youtube.com/vi/Oa_RSwwpPaA/maxresdefault.jpg",
    },
    {
      "name": "Relight My Fire — Take That feat. Lulu",
      "videoId": "40Od45DjCA4",
      "thumbnail": "https://img.youtube.com/vi/40Od45DjCA4/maxresdefault.jpg",
    },
    {
      "name": "Feel The Love — Rudimental feat. John Newman",
      "videoId": "lmXtu50qGZo",
      "thumbnail": "https://img.youtube.com/vi/lmXtu50qGZo/maxresdefault.jpg",
    },
    {
      "name": "Sk8er Boi — Avril Lavigne",
      "videoId": "TIy3n2b7V9k",
      "thumbnail": "https://img.youtube.com/vi/TIy3n2b7V9k/maxresdefault.jpg",
    },
    {
      "name": "Take Me Home, Country Roads — John Denver",
      "videoId": "1vrEljMfXYo",
      "thumbnail": "https://img.youtube.com/vi/1vrEljMfXYo/maxresdefault.jpg",
    },
    {
      "name": "Stand By Me — Ben E. King",
      "videoId": "hwZNL7QVJjE",
      "thumbnail": "https://img.youtube.com/vi/hwZNL7QVJjE/maxresdefault.jpg",
    },
    {
      "name": "Time Of Our Lives — Pitbull & Ne‑Yo",
      "videoId": "bTXJQ5ql5Fw",
      "thumbnail": "https://img.youtube.com/vi/bTXJQ5ql5Fw/maxresdefault.jpg",
    },
    {
      "name": "Like A Prayer — Madonna",
      "videoId": "79fzeNUqQbQ",
      "thumbnail": "https://img.youtube.com/vi/79fzeNUqQbQ/maxresdefault.jpg",
    },
    {
      "name": "December 1963 (Oh What A Night) — Four Seasons",
      "videoId": "mTUhnIY3oRM",
      "thumbnail": "https://img.youtube.com/vi/mTUhnIY3oRM/maxresdefault.jpg",
    },
    {
      "name": "Hotel Room Service — Pitbull",
      "videoId": "2up_Eq6r6Ko",
      "thumbnail": "https://img.youtube.com/vi/2up_Eq6r6Ko/maxresdefault.jpg",
    },
    {
      "name": "Cheerleader — OMI",
      "videoId": "I_NVUZNsh2E",
      "thumbnail": "https://img.youtube.com/vi/I_NVUZNsh2E/maxresdefault.jpg",
    },
    {
      "name": "Keep On Movin' — Soul II Soul",
      "videoId": "1iQl46‑zIcM",
      "thumbnail": "https://img.youtube.com/vi/1iQl46‑zIcM/maxresdefault.jpg",
    },
    {
      "name": "One Step Beyond — Madness",
      "videoId": "bhBs1RXpD9I",
      "thumbnail": "https://img.youtube.com/vi/bhBs1RXpD9I/maxresdefault.jpg",
    },
    {
      "name": "Firework — Katy Perry",
      "videoId": "QGJuMBdaqIw",
      "thumbnail": "https://img.youtube.com/vi/QGJuMBdaqIw/maxresdefault.jpg",
    },
    {
      "name": "Islands In The Stream — Kenny Rogers & Dolly Parton",
      "videoId": "HQW7I62TNOw",
      "thumbnail": "https://img.youtube.com/vi/HQW7I62TNOw/maxresdefault.jpg",
    },
    {
      "name": "This Will Be (An Everlasting Love) — Natalie Cole",
      "videoId": "rbaoKL1Ei0c",
      "thumbnail": "https://img.youtube.com/vi/rbaoKL1Ei0c/maxresdefault.jpg",
    },
    {
      "name": "Sugar — Maroon 5",
      "videoId": "09R8_2nJtjg",
      "thumbnail": "https://img.youtube.com/vi/09R8_2nJtjg/maxresdefault.jpg",
    },
    {
      "name": "That Don’t Impress Me Much — Shania Twain",
      "videoId": "eFjjO_lhf9c",
      "thumbnail": "https://img.youtube.com/vi/eFjjO_lhf9c/maxresdefault.jpg",
    },
    {
      "name": "Play That Funky Music — Wild Cherry",
      "videoId": "BHcYFxU4fMo",
      "thumbnail": "https://img.youtube.com/vi/BHcYFxU4fMo/maxresdefault.jpg",
    },
    {
      "name": "You’re The First, The Last, My Everything — Barry White",
      "videoId": "oepmH8S6ivA",
      "thumbnail": "https://img.youtube.com/vi/oepmH8S6ivA/maxresdefault.jpg",
    }
  ].obs;*/
