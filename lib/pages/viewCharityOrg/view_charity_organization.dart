import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/globalModels/user_model.dart';
import 'package:musit/pages/sender_side/sender_send_song/add_songs/controller/add_songs_controller.dart';
import 'package:musit/pages/viewCharityOrg/widget/view_carity_card.dart';
import 'package:musit/services/auth_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/show_payment_bootm_sheet.dart';

import '../../../../widgets/custom_text_field.dart';
import '../summaryPage/summary_page.dart';
import 'controller/view_charity_org_controller.dart';

class ViewCharityOrganization extends StatelessWidget {
  ViewCharityOrganization({
    super.key,
  });

  final controller = Get.put(ViewCharityOrgController());
  final RxBool isSelected = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'Charity Organizations',
            isBack: true,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                children: [
                  CustomTextField(
                    borderRadius: 50,
                    controller: controller.searchController,
                    hintText: 'Search',
                    isSuffixIcon: true,
                    suffixIcon: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: blackColor,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/search_icon.png',
                        scale: 3,
                      ),
                    ),
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        controller.searchQuery.value = '';
                      } else {
                        controller.searchQuery.value = value.trim();
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Obx(
                        () => FutureBuilder(
                            key: ValueKey(controller.searchQuery.value),
                            future: AuthService().getAllCharity(
                              search: controller.searchQuery.value,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox(
                                  height: Get.height / 3,
                                  child: Center(
                                      child: CircularProgressIndicator()),
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
                                    child: Center(
                                        child: Text("Empty",
                                            style: manRopeSemiBold)),
                                  ),
                                  // child: Center(
                                  //     child: Text("No User Found",
                                  //         style: manRopeSemiBold)),
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
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 13.0,
                                  mainAxisSpacing: 10.0,
                                  mainAxisExtent: 150,
                                ),
                                itemCount: userList.length,
                                itemBuilder: (context, index) {
                                  final charityUser = userList[index];

                                  return Obx(() {
                                    bool? isSelected =
                                        controller.selectedCharity.value ==
                                            userList[index].id;
                                    return ViewCharityCard(
                                      user: UserModel(
                                        profile: RxString(
                                            charityUser.user?.profile ?? ''),
                                        username: TextEditingController(
                                            text: charityUser.organtization ??
                                                ''),
                                      ),
                                      isSelected: isSelected,
                                      onTap: () async {
                                        controller.selectedCharity.value =
                                            userList[index].id;
                                      },
                                    );
                                  });
                                },
                              );
                            }),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  Center(
                      child: Text('Would you like to donate extra ',
                          textAlign: TextAlign.center,
                          style: manRope.copyWith(fontSize: 13))),

                  SizedBox(height: 6),
                  CustomButton(
                      onPressed: () {
                        if (controller.selectedCharity.value == null) {
                          customErrorSnackBar(
                              content: "Select Charity to continue");
                          return;
                        }
                        showPaymentBottomSheet(
                            context: context,
                            onAmountSubmitted: (amount) {
                              Get.back();
                              Get.find<AddSongsController>()
                                  .moreCharityAmount
                                  .value = amount;
                            });
                      },
                      text: 'Donate'),
                  SizedBox(height: 6),
                  CustomButton(
                      onPressed: () {
                        if (controller.selectedCharity.value == null) {
                          customErrorSnackBar(
                              content: "Select Charity to continue");
                          return;
                        }

                        Get.find<AddSongsController>().selectedCharityId.value =
                            controller.selectedCharity.value;

                        Get.to(() => SentSongSummaryPage());
                      },
                      text: 'Next'),
                  SizedBox(height: 16),
                  // Center(
                  //     child: Text(
                  //         'Please select your chosen charity to receive 50p of your MUSEiT Moment',
                  //         textAlign: TextAlign.center,
                  //         style: manRope.copyWith(fontSize: 13))),
                  // SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
