import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/services/paylist_service.dart';

import '../../../../common_widgets/recipients_card.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';
import '../../../../widgets/custom_app_bar.dart';

class PlaylistRecipientScreen extends StatelessWidget {
  PlaylistRecipientScreen({super.key, this.playlistId});


  final int? playlistId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'Recipients',
            isBack: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: PlaylistService().getPlaylistRecipientUsers(
                    playlistId: playlistId,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: Get.height / 3,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (snapshot.hasError) {
                      return SizedBox(
                        height: Get.height / 3,
                        child: Center(
                            child: Text(snapshot.error.toString(),
                                style: manRopeSemiBold)),
                      );
                    }

                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return SizedBox(
                        height: Get.height / 3,
                        child: Center(
                            child:
                            Text("No User Found", style: manRopeSemiBold)),
                      );
                    }

                    final userList = snapshot.requireData;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      primary: false,
                      padding: EdgeInsets.only(bottom: 30),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 13.0,
                        mainAxisSpacing: 10.0,
                        mainAxisExtent: 150,
                      ),
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return RecipientsCard(
                          user: userList[index].toUser!,
                          isSelected: false,
                        );
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
