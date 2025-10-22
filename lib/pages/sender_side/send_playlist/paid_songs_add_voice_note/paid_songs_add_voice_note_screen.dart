import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/globalModels/song_model.dart';
import 'package:musit/services/upload_file_service.dart';
import 'package:musit/utils/extensions.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_voice_recording_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../services/api_service.dart';
import '../../../../services/paylist_service.dart';
import '../../../../utils/dialog_utilities.dart';
import '../../sender_home/playlist_sent_bottom_sheet/playlist_sent_bottom_sheet.dart';
import '../../sender_home/sender_home/sender_home_screen.dart';
import '../../sender_home/sender_view_recipient/sender_view_recipient_screen.dart';

class PaidSongsAddVoiceNoteScreen extends StatelessWidget {
  const PaidSongsAddVoiceNoteScreen({super.key, required, required this.song});

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Add Voice Note', isBack: true),
          _buildPaidSongTile(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomVoiceRecordingScreen(
                onNext: (RxList<SongModel> songs) async {
                  Get.to(() => SenderViewRecipientScreen(
                        onPressedSave: (List<int> selectedUsers) async {
                          ///if selected users are not empty
                          if (selectedUsers.isNotEmpty) {
                            ///if recording are not empty
                            ///
                            List<String> recordingUrls = [];
                            Map<String, dynamic> recordingData = {};
                            if (songs.isNotEmpty) {
                              List<String> recordingPaths = songs
                                  .map((e) => e.link)
                                  .whereType<String>()
                                  .where((path) => path.isNotEmpty)
                                  .toList();

                              ///if recording urls are empty
                              if (recordingPaths.isEmpty) {
                                errorDialog(
                                    content:
                                        "Something went wrong try again later");
                                return;
                              }

                              try {
                                ///upload audio files to server
                                recordingUrls = await UploadFileService()
                                    .uploadMultipleImagesFast(recordingPaths);
                              } catch (e) {
                                errorDialog(content: e.toString());
                                return;
                              }
                            }
                            if (recordingUrls.isNotEmpty) {
                              //later upload whole voice note list but for
                              // now just 1
                              // recordingData['notes'] = recordingUrls
                              //    .map((vc) =>
                              //        {"name": vc.split('.').first, "link": vc})
                              //    .toList();
                              recordingData['notes'] = [
                                {
                                  "name": recordingUrls[0].split('.').first,
                                  "link": recordingUrls[0]
                                }
                              ];
                            }

                            int? voiceNoteId;

                            ///now upload these notes to server and get id
                            ///
                            await ApiService().handleResponse(
                              apiMethod: () =>
                                  PlaylistService().voicenote(recordingData),
                              onSuccess: (success) async {
                                await Future.delayed(
                                    Duration(milliseconds: 400));
                                voiceNoteId = success['response']['id'];
                              },
                            );

                            ///now share paid songs
                            await ApiService().handleResponse(
                              apiMethod: () => PlaylistService().share(
                                  toUserIds: selectedUsers,
                                  typeId: 1,
                                  id: song.id,
                                  voiceNoteId: voiceNoteId),
                              onSuccess: (success) async {
                                await Future.delayed(
                                    Duration(milliseconds: 1200));
                                Get.offAll(() => SenderHomeScreen());
                                playlistSentBottomSheet(() {
                                  Get.back();
                                }, "Your paid song has been shared.");
                              },
                            );
                          } else {
                            confirmationDialog(
                                content: "No user selected.",
                                confirmText: "Select Later",
                                cancelText: "Select Now",
                                onConfirm: () {
                                  Get.offAll(() => SenderHomeScreen());
                                });
                          }
                        },
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildPaidSongTile() {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  left: BorderSide(color: blueColor, width: 0.7),

                  right: BorderSide(color: blueColor, width: 0.7),
                  bottom: BorderSide(color: blueColor, width: 0.7),
                  // top ko intentionally blank rakha
                ),
              ),
            ),
          ),

          // ✅ Content of card
          Padding(
            padding: const EdgeInsets.only(
              left: 6,
              right: 20,
              top: 6,
              bottom: 6,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: song.image.showImage,
                    // Your backend image URL
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 60,
                          width: 60,
                          color: Colors.grey.shade300,
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 60,
                          width: 60,
                          color: Colors.grey.shade300,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 12),

                // Name + Plan (left side text)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.name ?? "N/A",
                        style: manRopeSemiBold.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Motivational',
                        style: manRope.copyWith(
                          fontSize: 12,
                          color: lightBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  children: [
                    SizedBox(height: 24),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Price ${song.price?.toString() ?? '-'}',
                        style: manRopeSemiBold.copyWith(fontSize: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
