import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/sender_side/sender_home/sender_home/sender_home_screen.dart';
import 'package:musit/pages/sender_side/sender_home/sender_view_recipient/sender_view_recipient_screen.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/paylist_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/utils/dialog_utilities.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import '../../../../common_widgets/song_card.dart';
import '../playlist_sent_bottom_sheet/playlist_sent_bottom_sheet.dart';
import 'controller/sender_created_playlist_controller.dart';
import '../../../../../globalModels/song_model.dart';

class SenderCreatedPlaylistScreen extends StatelessWidget {
  SenderCreatedPlaylistScreen({super.key, this.playListId});

  final int? playListId;
  final controller = Get.put(SenderCreatedPlaylistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Created Playlist', isBack: true),
          Expanded(
            child: FutureBuilder<List<SongModel>>(
              future: controller.getPlayListById(playListId),
              builder: (context, snapshot) {
                // 🌀 Loading State
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // ⚠️ Error State
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Something went wrong: ${snapshot.error}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                // 📭 Empty Data
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "No songs found in this playlist",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                // ✅ Data Available
                final songs = snapshot.data!;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // inside FutureBuilder (replace ListView.builder)
                      ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        onReorder: (oldIndex, newIndex) {
                          if (newIndex > oldIndex) newIndex -= 1;
                          final item = songs.removeAt(oldIndex);
                          songs.insert(newIndex, item);
                        },
                        itemCount: songs.length,
                        buildDefaultDragHandles: false,
                        // 🧩 Custom feedback UI to remove double shadow
                        proxyDecorator: (Widget child, int index,
                            Animation<double> animation) {
                          return Material(
                            color: Colors.transparent,
                            elevation: 0, // remove any extra shadow
                            child:
                                child, // still shows the same widget, but no extra overlay shadow
                          );
                        },

                        itemBuilder: (context, index) {
                          final song = songs[index];
                          return Padding(
                            key: ValueKey(song.id),
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SongCard(
                              key: ValueKey(song.id),
                              model: song,
                              index: index,
                              showPlaylistIcon: true, // drag handle icon inside
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(
                color: redColor,
                iconPath: 'assets/images/delete_icon.png',
                onTap: () {
                  // TODO: Add delete playlist logic
                },
              ),
              const SizedBox(width: 8),
              _buildActionButton(
                color: blackColor,
                iconPath: 'assets/images/double_forwareded_icon.png',
                onTap: () {
                  Get.to(() => SenderViewRecipientScreen(
                        onPressedSave: (List<int> selectedUsers) async {
                          if (selectedUsers.isNotEmpty) {
                            await ApiService().handleResponse(
                              apiMethod: () => PlaylistService().share(
                                  toUserIds: selectedUsers,
                                  typeId: 1,
                                  id: playListId),
                              onSuccess: (success) async {
                                await Future.delayed(
                                    Duration(milliseconds: 1500));
                                playlistSentBottomSheet(() {
                                  Get.offAll(() => SenderHomeScreen());
                                });
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
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // 🔘 Reusable Action Button
  Widget _buildActionButton({
    required Color color,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 1,
            right: 1,
            bottom: -3,
            child: Container(
              height: 30,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: blueColor,
              ),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: color,
            ),
            child: Image.asset(iconPath, scale: 3),
          ),
        ],
      ),
    );
  }
}
