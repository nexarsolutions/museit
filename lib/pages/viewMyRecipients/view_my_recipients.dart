import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/common_widgets/recipients_card.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/globalModels/user_model.dart';
import 'package:musit/services/auth_service.dart';
import 'package:musit/widgets/custom_app_bar.dart';

class ViewMyRecipients extends StatelessWidget {
  ViewMyRecipients({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'Recipients',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Obx(
                () => FutureBuilder(
                    future: AuthService().getAllMyRecipients(),
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
                              child: Text("Empty", style: manRopeSemiBold)),
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
                          final user = userList[index];
                          return RecipientsCard(
                            user: UserModel(
                                id: user.id,
                                username: TextEditingController(
                                    text: user.username ?? ''),
                                email: TextEditingController(
                                    text: user.email ?? ''),
                                profile: RxString(user.profile ?? '')),
                            isSelected: false,
                          );
                        },
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
