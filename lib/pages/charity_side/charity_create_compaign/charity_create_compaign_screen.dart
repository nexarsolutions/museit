
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/custom_drop_down.dart';
import 'package:musit/widgets/custom_image_picker.dart';
import 'package:musit/widgets/custom_text_field.dart';
import 'package:musit/utils/validators.dart';

import 'controller/charity_create_compaign_controller.dart';

class CharityCreateCampaignScreen extends StatelessWidget {
  CharityCreateCampaignScreen({super.key});

  final controller = Get.put(CharityCreateCampaignController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Create Campaign', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Campaign Title', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.compaignTitleController,
                      hintText: 'Add text',
                      validator: validateIsEmpty,
                    ),
                    const SizedBox(height: 10),
                    Text('Monthly Aid Goal', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.monthlyAidGoalController,
                      hintText: 'Add text',
                      keyboardType: TextInputType.number,
                      validator: validateIsEmpty,
                    ),
                    const SizedBox(height: 10),
                    // Text('Select Playlist', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    // const SizedBox(height: 8),
                    // Obx(
                    //       () => CustomDropDown(
                    //     dropdownItems: controller.playlistList,
                    //     hintText: controller.selectedPlaylist.value,
                    //     onChanged: (val) {
                    //       controller.selectedPlaylist.value = val!;
                    //     },
                    //     value: controller.selectedPlaylist.value,
                    //     validator: (val) => val == null || val.isEmpty ? 'Select Playlist' : null,
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    Text('Cause', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.causeController,
                      hintText: 'Add text',
                      maxLines: 6,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      validator: validateIsEmpty,
                    ),
                    const SizedBox(height: 10),
                    Text('Upload Image', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    const SizedBox(height: 8),
                    CustomImagePicker(pickedImagePath: controller.pickedImagePath),
                    // const SizedBox(height: 10),
                    // Text('Goal Amount', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    // const SizedBox(height: 8),
                    // CustomTextField(
                    //   controller: controller.goalAmountController,
                    //   hintText: 'Add text',
                    //   keyboardType: TextInputType.number,
                    //   validator: validateIsEmpty,
                    // ),
                    // const SizedBox(height: 10),
                    // Text('Bank Name', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    // const SizedBox(height: 8),
                    // CustomTextField(
                    //   controller: controller.bankNameController,
                    //   hintText: 'Add text',
                    //   validator: validateIsEmpty,
                    // ),
                    // const SizedBox(height: 10),
                    // Text('Account Number', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    // const SizedBox(height: 8),
                    // CustomTextField(
                    //   controller: controller.accountNumberController,
                    //   hintText: 'Add text',
                    //   validator: validateIsEmpty,
                    // ),
                    // const SizedBox(height: 10),
                    // Text('Account Title', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    // const SizedBox(height: 8),
                    // CustomTextField(
                    //   controller: controller.accountTitleController,
                    //   hintText: 'Add text',
                    //   validator: validateIsEmpty,
                    // ),
                    const SizedBox(height: 36),
                    Center(
                      child: CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            controller.submitCampaign(isPublish: true);
                          }
                        },
                        text: 'Publish',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            controller.submitCampaign(isPublish: false);
                          }
                        },
                        child: Container(
                          width: 220,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: blackColor, width: 1),
                          ),
                          child: Center(
                            child: Text('Save in Drafts', style: manRopeSemiBold.copyWith(fontSize: 14)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
