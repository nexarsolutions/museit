import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/common_widgets/recipients_card.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/globalModels/user_model.dart';
import 'package:musit/main.dart';
import 'package:musit/pages/allRecipients/all_recipients.dart';
import 'package:musit/pages/sender_side/sender_home/preSavedRecipients/controller/pre_saved_recipients_controller.dart';
import 'package:musit/pages/sender_side/sender_home/preSavedRecipients/widget/view_cart.dart';
import 'package:musit/services/auth_service.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../globalModels/presaved_receipents.dart';
import '../../../../widgets/custom_button.dart';

class PreSavedRecipientsScreen extends StatelessWidget {
  PreSavedRecipientsScreen({super.key, required this.onPressedSave});

  final controller = Get.put(PreSavedRecipientsController());
  final Function(List<PreSavedRecipient> selectedUsersId, bool addToCart)
      onPressedSave;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'Recipients',
            isBack: true,
            lastWidget: IconButton(
              onPressed: () {
                Get.to(() => AllRecipients(
                      onPressedSave: () {
                        Get.back(); //close screen
                        controller.isLoading.toggle();
                      },
                    ));
              },
              icon: Icon(Icons.add),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(blackColor),
                foregroundColor: WidgetStatePropertyAll(whiteColor),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Obx(
                () => FutureBuilder(
                    key: ValueKey(controller.isLoading.value),
                    future: AuthService().getAllPreSavedRecipients(),
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
                          return Obx(
                            () {
                              bool? isSelected =
                                  controller.selectedUsersId.value.any(
                                (element) => element.id == userList[index].id,
                              );

                              return RecipientsCard(
                                user: userList[index].recipient != null
                                    ? userList[index].recipient!
                                    : UserModel(
                                        id: userList[index].id,
                                        username: TextEditingController(
                                            text: userList[index].name ?? ''),
                                        email: TextEditingController(
                                            text: userList[index].email ?? ''),
                                        phone: TextEditingController(
                                            text: userList[index].phone ?? ''),
                                        profile: RxString(
                                            userList[index].picture ?? ''),
                                      ),
                                isSelected: isSelected,
                                onTap: () {
                                  if (isSelected) {
                                    controller.selectedUsersId.removeWhere(
                                        (element) =>
                                            element.id == userList[index].id);
                                  } else {
                                    if (userList[index].id != null) {
                                      controller.selectedUsersId.clear();
                                      controller.selectedUsersId
                                          .add(userList[index]);
                                    }
                                  }
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 10,
              children: [
                Flexible(
                  child: CustomButton(
                      onPressed: () {
                        // if (controller.selectedUsersId.value.isEmpty) {
                        //   errorDialog(
                        //       content: "Select User/Receipt to continue.");
                        //   return;
                        // }
                        print("length0");

                        print(controller.selectedUsersId.length);
                        onPressedSave(controller.selectedUsersId.value, false);
                      },
                      text: 'Send'),
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          print("length");
                          print(controller.selectedUsersId.length);

                          onPressedSave(controller.selectedUsersId.value, true);
                        },
                        icon: Icon(
                          Icons.add_shopping_cart_outlined,
                        )),
                    Text("Add to Cart ")
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                            SafeArea(
                                child: CartListBottomSheet(
                                    cartItems: userManager.cartItems)),
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.shopping_basket_sharp,
                        )),
                    Text("View Cart ")
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
