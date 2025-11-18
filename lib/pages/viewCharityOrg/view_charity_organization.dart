import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/common_widgets/recipients_card.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/globalModels/payment_model.dart';
import 'package:musit/globalModels/user_model.dart';
import 'package:musit/pages/sender_side/sender_home/sender_home/sender_home_screen.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/auth_service.dart';
import 'package:musit/services/payment_service.dart';
import 'package:musit/utils/dialog_utilities.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/show_payment_bootm_sheet.dart';

import '../../../../widgets/custom_text_field.dart';
import '../../widgets/web_view_screen.dart';
import '../sendBottombar/sender_bottom_bar.dart';
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
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;

          Get.offAll(() => SenderBottomBar());
        },
        child: Column(
          children: [
            CustomAppBar(
              text: 'Charity Organizations',
              isBack: true,
              onTap: () {
                Get.offAll(() => SenderBottomBar());
              },
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
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 13.0,
                                    mainAxisSpacing: 10.0,
                                    mainAxisExtent: 150,
                                  ),
                                  itemCount: userList.length,
                                  itemBuilder: (context, index) {
                                    final charityUser = userList[index];
                                    return RecipientsCard(
                                      user: UserModel(
                                        profile: RxString(
                                            charityUser.user?.profile ?? ''),
                                        username: TextEditingController(
                                            text: charityUser.organtization ??
                                                ''),
                                      ),
                                      isSelected: false,
                                      showDonate: true,
                                      onTap: () async {
                                        /// phone bottom sheet
                                        showPaymentBottomSheet(
                                          context: context,
                                          onAmountSubmitted: (amount) async {
                                            Get.back(); //close bottom sheet

                                            ///initial payment
                                            await ApiService().handleResponse(
                                              loadingMsg: "Initiating Payment",
                                              apiMethod: () => PaymentService()
                                                  .initPaymentApi(
                                                      amount: amount,
                                                      charityId: userList[index]
                                                              .user
                                                              ?.id ??
                                                          (-1)),
                                              onSuccess: (success) {
                                                //
                                                final paymentResponse =
                                                    PaymentResponseModel
                                                        .fromJson(success);
                                                final paypal = paymentResponse
                                                    .data?.paypal;

                                                String? approvalLink =
                                                    paypal?.approvalLink;

                                                if (approvalLink == null) {
                                                  errorDialog(
                                                      content:
                                                          "Failed to proceed "
                                                          "with payment");
                                                  return;
                                                }

                                                Get.to(() => WebViewScreen(
                                                      url: approvalLink!,
                                                      title: "Payment",
                                                    ));
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              }),
                        ),
                      ),
                    ),
                    SizedBox(height: 42),
                    CustomButton(
                        onPressed: () {
                          Get.offAll(() => SenderBottomBar());
                        },
                        text: 'Next'),
                    SizedBox(height: 16),
                    Center(
                        child: Text(
                            'Please select your chosen charity to receive 50p of your MUSEiT Moment',
                            textAlign: TextAlign.center,
                            style: manRope.copyWith(fontSize: 13))),
                    SizedBox(height: 6),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
