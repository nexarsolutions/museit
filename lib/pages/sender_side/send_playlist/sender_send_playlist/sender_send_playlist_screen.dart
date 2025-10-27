// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:musit/constants/colors.dart';
// import 'package:musit/pages/sender_side/send_playlist/sender_send_playlist/controller/sender_send_playlist_controller.dart';
// import 'package:musit/utils/dialog_utilities.dart';
// import 'package:musit/widgets/custom_app_bar.dart';
// import 'package:musit/widgets/custom_tab_button.dart';
//
// import '../../../../constants/global_list.dart';
// import '../../../../constants/text_styles.dart';
// import '../../../../services/song_service.dart';
// import '../../../music_player/music_player_screen.dart';
// import '../../profile/purchase_history/widget/paid_songs_widget.dart';
// import '../../subscriptions/payment_details/payment_details_screen.dart';
// import '../paid_songs_add_voice_note/paid_songs_add_voice_note_screen.dart';
//
// class SenderSendPlaylistScreen extends StatelessWidget {
//    SenderSendPlaylistScreen({super.key});
//
//   final controller = Get.put(SenderSendPlaylistController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteColor,
//       body: Column(
//         children: [
//           CustomAppBar(
//             text: 'Send a MUSE',
//             isBack: true,
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 children: [
//                   Obx(
//                     () => CustomTabButton(
//                       tabNames: playlistPurposes,
//                       selectedIndex: controller.selectedTab.value,
//                       onTabSelected: (index) {
//                         controller.selectedTab.value = index;
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   Obx(
//                     () => FutureBuilder(
//                         key: ValueKey(controller.selectedTab.value),
//                         future: PlaylistService()
//                             .getSongs(typeId: controller.selectedTab.value + 1),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return Center(child: CircularProgressIndicator());
//                           }
//                           if (snapshot.hasError) {
//                             return Center(
//                                 child: Text(snapshot.error.toString(),
//                                     style: manRopeSemiBold));
//                           }
//
//                           if (!snapshot.hasData ||
//                               snapshot.data == null ||
//                               snapshot.data!.isEmpty) {
//                             return Center(
//                                 child: Text("No Songs Found",
//                                     style: manRopeSemiBold));
//                           }
//
//                           final songsList = snapshot.requireData;
//                           return GridView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             padding: EdgeInsets.only(bottom: 30),
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               crossAxisSpacing: 13.0,
//                               mainAxisSpacing: 10.0,
//                               mainAxisExtent: 145,
//                             ),
//                             itemCount: songsList.length,
//                             itemBuilder: (context, index) {
//                               final song = songsList[index];
//
//                               return GestureDetector(
//                                 onTap: () {
//                                   // if (song.isBuy.value == false) {
//                                   //   confirmationDialog(
//                                   //     title: "Info",
//                                   //     content: "You have not bought this "
//                                   //         "song.\nBuy to share",
//                                   //     cancelText: "Later",
//                                   //     confirmText: "Buy now",
//                                   //     onConfirm: () {
//                                   //       Get.back();
//                                   //       Get.to(()=>PaymentDetailsScreen());
//                                   //     },
//                                   //   );
//                                   // }
//
//                                   Get.to(() =>
//                                       PaidSongsAddVoiceNoteScreen(song: song));
//                                 },
//                                 child: PaidSongsWidget(
//                                   model: songsList[index],
//                                 ),
//                               );
//                             },
//                           );
//                         }),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
