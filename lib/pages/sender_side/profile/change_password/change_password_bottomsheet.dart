import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';

import '../../../../utils/validators.dart';
import '../../../../widgets/custom_bottom_sheet.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../edit_profile/controller/edit_profile_controller.dart';

changePasswordBottomSheet(){
  final controller = Get.put(EditProfileController());
  final formKey = GlobalKey<FormState>();

  return customBottomSheet(

    margin: EdgeInsets.all(8),
      child: Column(
    children: [
      SizedBox(height: 24,),
      Text(
        'Change Password',
        style: manRopeSemiBold.copyWith(
          fontSize: 14,
        ),
      ),
      Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 36,
            ),
            Text(
              'Current Password',
              style: manRopeSemiBold.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(
                  () => CustomTextField(
                controller: controller.currentPasswordController,
                hintText: '*********',
                isSuffixIcon: true,
                    isPrefixIcon: true,
                    prefixIcon: Image.asset(
                      'assets/images/lock.png',
                      height: 24,
                      width: 24,
                      scale: 3.5,
                    ),

                    obscureText: controller.isCurrentPasswordHidden.value,
                suffixIcon: InkWell(
                  onTap: () {
                    controller.isCurrentPasswordHidden.value =
                    !controller.isCurrentPasswordHidden.value;
                  },
                  child: controller.isCurrentPasswordHidden.value
                      ? const Icon(
                    Icons.visibility_off_outlined,
                    color: lightBlack,
                    size: 20,
                  )
                      : const Icon(
                    Icons.visibility,
                    color: lightBlack,
                    size: 20,
                  ),
                ),
                validator: (value) {
                  return isPasswordValid(
                    value!,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'New Password',
              style: manRopeSemiBold.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
                  () => CustomTextField(
                controller: controller.newPasswordController,
                hintText: '*********',
                isSuffixIcon: true,
                    isPrefixIcon: true,
                    prefixIcon: Image.asset(
                      'assets/images/lock.png',
                      height: 24,
                      width: 24,
                      scale: 3.5,
                    ),

                    obscureText: controller.isNewPasswordHidden.value,
                suffixIcon: InkWell(
                  onTap: () {
                    controller.isNewPasswordHidden.value =
                    !controller.isNewPasswordHidden.value;
                  },
                  child: controller.isNewPasswordHidden.value
                      ? const Icon(
                    Icons.visibility_off_outlined,
                    color: lightBlack,
                    size: 20,
                  )
                      : const Icon(
                    Icons.visibility,
                    color: lightBlack,
                    size: 20,
                  ),
                ),
                validator: (value) {
                  return isPasswordValid(
                    value!,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Confirm Password',
              style: manRopeSemiBold.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
                  () => CustomTextField(
                controller: controller.confirmPasswordController,
                hintText: '*********',
                isSuffixIcon: true,
                    isPrefixIcon: true,
                    prefixIcon: Image.asset(
                      'assets/images/lock.png',
                      height: 24,
                      width: 24,
                      scale: 3.5,
                    ),

                    obscureText: controller.isConfirmPasswordHidden.value,
                suffixIcon: InkWell(
                  onTap: () {
                    controller.isConfirmPasswordHidden.value =
                    !controller.isConfirmPasswordHidden.value;
                  },
                  child: controller.isConfirmPasswordHidden.value
                      ? const Icon(
                    Icons.visibility_off_outlined,
                    color: lightBlack,
                    size: 20,
                  )
                      : const Icon(
                    Icons.visibility,
                    color: lightBlack,
                    size: 20,
                  ),
                ),
                validator: (value) {
                  return isConfirmPasswordValid(
                    value!,
                    controller.newPasswordController.text,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const SizedBox(
              height: 42,
            ),
            Center(
              child: CustomButton(
                width: 248,
                text: 'Save',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Get.back();
                  }
                },
              ),
            )
          ],
        ),
      )
    ],
  ));
}