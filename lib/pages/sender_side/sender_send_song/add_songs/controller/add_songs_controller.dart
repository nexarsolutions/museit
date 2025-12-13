import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:music_kit/music_kit.dart';
import 'package:musit/globalModels/admin_songs_model.dart';
import 'package:musit/globalModels/cart_model.dart';
import 'package:musit/main.dart';
import 'package:musit/pages/sendBottombar/widget/thank_you_page.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/song_service.dart';
import 'package:musit/services/upload_file_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../constants/app_enums.dart';
import '../../../../../globalModels/presaved_receipents.dart';
import '../../../../../globalModels/song_model.dart';
import '../../../../../services/apple_music_service.dart';
import '../../../../../services/spotify_auth_service.dart';
import '../../../../../utils/global_functions.dart';
import '../../../../../widgets/web_view_screen.dart';
import '../../../../sendBottombar/sender_bottom_bar.dart';
import '../../../../summaryPage/summary_page.dart';
import '../../../../viewCharityOrg/view_charity_organization.dart';
import '../../../sender_home/preSavedRecipients/widget/view_cart.dart';

class AddSongsController extends GetxController {
  final spotifyService = Get.find<SpotifyAuthService>();
  final appleMusicService = AppleMusicService();

  final RxInt songTypeId = 0.obs;
  final searchController = TextEditingController();
  RxString searchQuery = ''.obs;
  final RxnInt selectedCharityId = RxnInt();
  final RxnDouble moreCharityAmount = RxnDouble();

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

  // Apple Music list
  final RxList<Map<String, dynamic>> searchAppleMusicList =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> _allAppleMusicSongs =
      <Map<String, dynamic>>[].obs; // Store all songs for filtering
  final RxBool isAppleMusicLoading = false.obs;

  // Default fallback songs for spotify
  final defaultSongs = [
    "top hits english songs of all time",
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

    // Check Apple Music connection status on init
    appleMusicService.checkConnection();

    ever(spotifyService.isConnected, (connected) {
      if (connected == true) loadDefaultSpotifySongs();
    });

    // Listen to Apple Music connection changes
    ever(appleMusicService.isConnected, (connected) {
      if (connected == true && songTypeId.value == 2) {
        loadDefaultAppleMusicSongs();
      }
    });

    ever(
      songTypeId,
      (typeId) {
        if (typeId == 0) {
          loadDefaultSpotifySongs();
        } else if (typeId == 1) {
          loadDefaultYoutubeSongs();
        } else if (typeId == 2) {
          // Check connection and load Apple Music library songs if connected
          appleMusicService.checkConnection().then((_) {
            if (appleMusicService.isConnected.value) {
              loadDefaultAppleMusicSongs();
            }
          });
        } else if (typeId == 3) {}
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
      } else if (songTypeId.value == 2) {
        // Apple Music search
        if (appleMusicService.isConnected.value) {
          query.toString().isEmpty
              ? loadDefaultAppleMusicSongs()
              : searchAppleMusic(query.toString());
        }
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
    print("************* $query");
    if (query.isEmpty) return loadDefaultSpotifySongs();

    isSpotifyLoading.value = true;
    try {
      final token = await spotifyService.getAccessToken();
      print("*********** 0 $token");
      if (token == null) {
        // isSpotifyLoading.value = false;
        return;
      }

      final url = Uri.parse(
          'https://api.spotify.com/v1/search?q=$query&type=track&limit=10');
      final res =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      print("spotify response ${res.body}");

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final List items = data['tracks']['items'];
        searchSpotifyResults.assignAll(items.map((track) {
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
    await searchYouTube(searchQuery.value.trim().isEmpty
        ? defaultSongs.first
        : searchQuery.value.trim());
  }

  // Load Apple Music library songs
  Future<void> loadDefaultAppleMusicSongs() async {
    if (!appleMusicService.isConnected.value) return;

    isAppleMusicLoading.value = true;
    try {
      final songs = await appleMusicService.fetchUserLibrarySongs(limit: 100);

      // Convert SongModel list to Map format for the widget
      final songsList = songs.map((song) {
        // Extract library song ID and catalog song ID from link
        // Format: /v1/me/library/songs/i.ZOMrKa1SrEPK64q|catalog:123456789
        String librarySongId = song.id?.toString() ?? '';
        String catalogSongId = '';

        if (song.link != null) {
          // Check if link contains catalog ID (format: link|catalog:ID)
          if (song.link!.contains('|catalog:')) {
            final parts = song.link!.split('|catalog:');
            catalogSongId = parts.length > 1 ? parts[1] : '';
            // Extract library song ID from the first part
            final linkPart = parts[0];
            final linkParts = linkPart.split('/');
            if (linkParts.isNotEmpty) {
              librarySongId = linkParts.last;
            }
          } else {
            // No catalog ID, extract from link normally
            final parts = song.link!.split('/');
            if (parts.isNotEmpty) {
              librarySongId = parts.last;
            }
          }
        }

        return {
          'id': librarySongId,
          'catalogId': catalogSongId, // Store catalog ID separately
          'name': song.name ?? '',
          'image': song.image ?? '',
          'link': song.link ?? '',
        };
      }).toList();

      // Store all songs for filtering
      _allAppleMusicSongs.assignAll(songsList);
      // Display all songs initially
      searchAppleMusicList.assignAll(songsList);
    } catch (e) {
      debugPrint("Error loading Apple Music library songs: $e");
      searchAppleMusicList.clear();
    } finally {
      isAppleMusicLoading.value = false;
    }
  }

  // Search Apple Music (filters library songs)
  Future<void> searchAppleMusic(String query) async {
    isAppleMusicLoading.value = true;
    try {
      if (query.trim().isEmpty) {
        // Show all songs if query is empty
        searchAppleMusicList.assignAll(_allAppleMusicSongs);
        return;
      }

      // If no songs loaded, load them first
      if (_allAppleMusicSongs.isEmpty) {
        await loadDefaultAppleMusicSongs();
      }

      // Filter from all songs
      final filteredSongs = _allAppleMusicSongs.where((song) {
        final songName = (song['name'] ?? '').toString().toLowerCase();
        final searchLower = query.toLowerCase();
        return songName.contains(searchLower);
      }).toList();

      if (filteredSongs.isEmpty) {
        searchAppleMusicList.clear();
      } else {
        searchAppleMusicList.assignAll(filteredSongs);
      }
    } catch (e) {
      debugPrint("Error searching Apple Music: $e");
      searchAppleMusicList.clear();
    } finally {
      isAppleMusicLoading.value = false;
    }
  }

  Future<void> searchYouTube(String query) async {
    isYoutubeLoading.value = true;

    try {
      final cleanQuery = query.trim();
      if (cleanQuery.isEmpty) {
        searchInYoutubeList.clear();
        return;
      }

      // Encode the query to handle spaces and special characters
      final encodedQuery = Uri.encodeQueryComponent(cleanQuery);

      final url = Uri.parse("https://www.googleapis.com/youtube/v3/search"
          "?part=snippet"
          "&q=$encodedQuery"
          "&type=video"
          "&maxResults=20"
          "&key=AIzaSyBDr9sg-4rttuwR3mczEIZJ6qPvA1pzYN8" // <-- Replace with your actual API key
          );

      final response = await http.get(url);

      if (response.statusCode != 200) {
        debugPrint("YT Error: ${response.body}");
        searchInYoutubeList.clear();
        return;
      }

      final json = jsonDecode(response.body);

      if (json["items"] == null || json["items"] is! List) {
        debugPrint("Invalid response format");
        searchInYoutubeList.clear();
        return;
      }

      final items = json["items"] as List;

      final results = items.map((item) {
        final snippet = item["snippet"];
        return {
          "videoId": item["id"]?["videoId"],
          "title": snippet?["title"],
          "thumbnail": snippet?["thumbnails"]?["high"]?["url"],
          "channel": snippet?["channelTitle"],
        };
      }).toList();

      searchInYoutubeList.assignAll(results);
    } catch (e) {
      debugPrint("YT Exception: $e");
      searchInYoutubeList.clear();
    } finally {
      isYoutubeLoading.value = false;
    }
  }

  ///via user account
  /*Future<void> searchYouTube(String query) async {
    isYoutubeLoading.value = true;

    try {
      if (query.trim().isEmpty) {
        searchInYoutubeList.clear();
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('youtubeAccessToken');

      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['https://www.googleapis.com/auth/youtube.readonly'],
      );

      GoogleSignInAccount? account;

      // ------------------------------------------------------
      // TOKEN VALIDATION BEFORE API REQUEST  🔥
      // ------------------------------------------------------
      if (accessToken != null) {
        final tokenCheck = await http.get(
          Uri.parse(
              "https://oauth2.googleapis.com/tokeninfo?access_token=$accessToken"),
        );

        if (tokenCheck.statusCode != 200) {
          debugPrint("Token invalid or expired → refreshing...");

          await prefs.remove('youtubeAccessToken');
          await googleSignIn.disconnect();

          return searchYouTube(query);
        }
      }
      // ------------------------------------------------------

      // If no token → force login
      if (accessToken == null) {
        account = await googleSignIn.signIn();
        if (account == null) {
          debugPrint('Login cancelled.');
          return;
        }

        final authHeaders = await account.authHeaders;
        accessToken = authHeaders['Authorization']?.split(' ').last;

        if (accessToken == null) {
          debugPrint('Failed to get token.');
          return;
        }

        await prefs.setString('youtubeAccessToken', accessToken);
      }

      // API request URL
      final url =
          'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&q=$query&maxResults=20';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
        },
      );

      // Token expired? Retry safely
      if (response.statusCode == 401) {
        debugPrint('Token expired → refreshing...');

        await prefs.remove('youtubeAccessToken');
        await googleSignIn.disconnect();

        return searchYouTube(query);
      }

      // Quota issues
      if (response.statusCode == 403) {
        debugPrint("Quota exceeded or forbidden: ${response.body}");
        return;
      }

      if (response.statusCode != 200) {
        debugPrint("Error: ${response.body}");
        searchInYoutubeList.clear();
        return;
      }

      final json = jsonDecode(response.body);

      final rawItems = json['items'];

      if (rawItems is! List) {
        debugPrint("Invalid API format. Items is not a list.");
        searchInYoutubeList.clear();
        return;
      }

      final items = rawItems
          .whereType<Map<String, dynamic>>()
          .cast<Map<String, dynamic>>()
          .toList();

      if (items.isEmpty) {
        searchInYoutubeList.clear();
        return;
      }

      searchInYoutubeList.assignAll(
        items.map((item) {
          final snippet = item['snippet'] ?? {};
          return {
            'videoId': item['id']?['videoId'],
            'title': snippet['title'],
            'thumbnail': snippet['thumbnails']?['high']?['url'],
            'channel': snippet['channelTitle'],
          };
        }).toList(),
      );
    } catch (e) {
      debugPrint("Exception occurred: $e");
      searchInYoutubeList.clear();
    } finally {
      isYoutubeLoading.value = false;
    }
  }*/

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

  /// Check if a string is a numeric catalog ID
  bool _isNumericCatalogId(String id) {
    if (id.isEmpty) return false;
    return RegExp(r'^\d+$').hasMatch(id);
  }

  /// Convert Apple Music API URL to public Apple Music web URL format
  /// Only converts when sharing - keeps API URLs for fetching
  /// Returns public URL like: https://music.apple.com/us/song/id/[catalog-id]
  String _convertToPublicAppleMusicUrl(SongModel song) {
    if (song.typeId != 3 || song.link == null || song.link!.isEmpty) {
      return song.link ?? '';
    }

    String link = song.link!;

    // Extract catalog ID if present in format: link|catalog:ID
    String? catalogId;
    if (link.contains('|catalog:')) {
      final parts = link.split('|catalog:');
      link = parts[0]; // Get the base link part
      if (parts.length > 1) {
        catalogId = parts[1];
      }
    }

    // If we have a valid catalog ID, convert to public Apple Music URL
    if (catalogId != null &&
        catalogId.isNotEmpty &&
        _isNumericCatalogId(catalogId)) {
      // Generate public Apple Music URL format: https://music.apple.com/[country]/song/id/[catalog-id]
      // Using 'us' as default country code (can be made configurable based on user's region)
      // Format: https://music.apple.com/us/song/id/[catalog-id]
      return 'https://music.apple.com/us/song/id/$catalogId';
    }

    // If no valid catalog ID found, we can't create a public Apple Music URL
    // Return the original link as-is (it will be the API URL format)
    return song.link ?? '';
  }

  RxList<PreSavedRecipient> preSavedRecipients = RxList();

  Future<void> addToCart(
      List<SongModel> voiceRecordings, List<PreSavedRecipient> selectedUsers,
      {bool fromAddCart = true}) async {
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

    userManager.cartItems.add(CartModel(
      defaultRecipientIds: RxList.from(selectedUsers.map((element) => element)),
      songs: RxList<SongModel>.from(songs.map(
        (element) => element,
      )),
      voices: RxList<Map<AudioKey, dynamic>>.from(voices.map(
        (e) => e,
      )),
    ));

    await Future.delayed(Duration(milliseconds: 500));

    if (fromAddCart) {
      Get.offAll(() => SenderBottomBar());
      customErrorSnackBar(content: "Successfully added to cart");
      songs.clear();
      selectedUsers.clear();
      voiceRecordings.clear();
    } else {
      Get.to(() => SentSongSummaryPage());
    }
  }

  Future<void> shareSong() async {
    // print(
    //     "Sharing song ${userManager.cartItems.first.defaultRecipientIds
    //         .length}");
    // print("preSavedRecipients ${preSavedRecipients.length}");
    // if (userManager.cartItems.first.defaultRecipientIds.isEmpty) {
    //   for (var ele in userManager.cartItems) {
    //     ele.defaultRecipientIds.clear();
    //     ele.defaultRecipientIds =
    //         RxList.from(preSavedRecipients.map((element) => element));
    //   }
    // }

    var data = {
      "cartItems": userManager.cartItems.map((e) => e.toMap()).toList(),
      "charityId": selectedCharityId.value,
      if (moreCharityAmount.value != null) "amount": moreCharityAmount.value
    };

    printInfo(info: data.toString());

    // Step 3: Call API to share songs
    await ApiService().handleResponse(
      apiMethod: () => SongService().shareSongs(data),
      onSuccess: (Map<String, dynamic> response) {
        customPrint("add_songs_controller line 64: $response");

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
        String orderId = responseData['orderId'] ?? '';

        if (!paymentRequired) {
          Get.offAll(() => SenderBottomBar());
          customErrorSnackBar(content: response['message']);
        } else {
          customPrint(approvalLink);
          Get.to(() => WebViewScreen(
                url: approvalLink,
                title: "Payment",
                onTap: () async {
                  Get.back();
                  await ApiService().handleResponse(
                    apiMethod: () =>
                        SongService().songPaymentStatusAPi(orderId: orderId),
                    onSuccess: (success) {
                      // bool isPaid = success['response']['isPaid'] ?? false;
                      // if (isPaid) {
                      //   Get.to(() => ViewCharityOrganization());
                      // } else {
                      Get.offAll(() => SenderBottomBar());
                      Get.bottomSheet(
                        SafeArea(
                            child:
                                ThankYouPage(cartItems: userManager.cartItems)),
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                      );
                      songTypeId.value = 0;
                      searchController.clear();
                      searchQuery.value = '';

                      songs.clear();

                      // RxList<SongModel> librarySelected = <SongModel>[].obs;
                      adminSongs.clear();

                      searchSpotifyResults.clear();

                      searchInYoutubeList.clear();
                      userManager.cartItems.clear();
                    },
                  );
                },
              ));
        }
      },
    );
  }

  // Future<void> shareMomentExternally(List<SongModel> songs, String platform,
  //     {String? receiver}) async {
  //   // Generate a message text
  //   String message = "Hey! Check out these songs I shared on MUSEiT 🎵\n\n";
  //   for (var song in songs) {
  //     message += "${song.name}\n";
  //     if (song.link != null) {
  //       if (song.typeId == 1) {
  //         String trackId = song.link.toString().split(':').last;
  //         message += 'https://open'
  //             '.spotify'
  //             '.com/embed/track/$trackId';
  //       } else if (song.typeId == 2) {
  //         message += 'https://www.youtube'
  //             '.com/watch?v=${song.link ?? ''}';
  //
  //         print("I am youtube");
  //       } else if (song.typeId == 3) {
  //         print("I am Apple");
  //       }
  //
  //       message += "${song.link}\n";
  //     }
  //   }
  //   // Optionally, add your app deep link
  //   message += "\nListen on MUSEiT: https://museit.app/moment";
  //
  //   Uri uri;
  //   switch (platform) {
  //     case 'SMS':
  //       uri = Uri.parse(
  //           "sms:${receiver ?? ''}?body=${Uri.encodeComponent(message)}");
  //       break;
  //     case 'WhatsApp':
  //       uri = Uri.parse(
  //           "https://wa.me/${receiver ?? ''}?text=${Uri.encodeComponent(message)}");
  //       break;
  //     case 'Email':
  //       uri = Uri(
  //         scheme: 'mailto',
  //         path: receiver ?? '',
  //         query:
  //             'subject=${Uri.encodeComponent("MUSEiT Moment")}&body=${Uri.encodeComponent(message)}',
  //       );
  //       break;
  //     default:
  //       throw "Unsupported platform";
  //   }
  //
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     throw 'Could not launch $uri';
  //   }
  // }

  var developerToken =
      "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjxLRVlfSUQ-In0.eyJpYXQiOjE3NjMxODk5MTIsImV4cCI6MTc3ODc0MTkxMiwiaXNzIjoiPFRFQU1fSUQ-In0.2em3TuAYPAcxYJpwVNznUUMA2DYMg8yrI5690fG852sQE_drX0PoL0ElKdtjCAIgRBbT0TZUwG7QFxCFkBHHAQ";

  Future<List<SongModel>> fetchUserLibrarySongs() async {
    final musicKit = MusicKit();

    // 1. Check authorization
    var status = await musicKit.authorizationStatus;
    if (status is! MusicAuthorizationStatusAuthorized) {
      status = await musicKit.requestAuthorizationStatus();
      if (status is! MusicAuthorizationStatusAuthorized) {
        throw Exception("Apple Music permission not granted.");
      }
    }

    // 2. Developer Token (must be generated on server)
    // const developerToken = "YOUR_DEVELOPER_TOKEN_HERE";

    // 3. User Token
    final userToken = await musicKit.requestUserToken(developerToken);
    if (userToken == null) {
      throw Exception("Unable to generate User Token.");
    }

    // 4. Fetch library songs from REST API
    final url =
        Uri.parse("https://api.music.apple.com/v1/me/library/songs?limit=100");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $developerToken",
        "Music-User-Token": userToken,
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch library songs: ${response.body}");
    }

    final json = jsonDecode(response.body);
    final List items = json["data"];

    // 5. Map to SongModel list
    List<SongModel> songs = items.map((item) {
      return SongModel(
        type: item["type"] ?? "",
        name: item["attributes"]?["name"] ?? "",
        link: item["href"] ?? "",
      );
    }).toList();

    return songs;
  }
}
