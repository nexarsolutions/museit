import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';
import '../../../../../globalModels/user_model.dart';
import '../../../../../services/api_service.dart';
import '../../../../../services/upload_file_service.dart';
import '../../../../../utils/custom_error_snack_bar.dart';
import '../../../../../utils/image_picker_bottom_sheet.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_field.dart';
import '../controller/pre_saved_recipients_controller.dart';

enum _RecipientAction { edit, remove }

/// -------------------- EDIT RECIPIENT DIALOG ----------------------

void showEditRecipientDialog({
  required BuildContext context,
  required UserModel user,
  required PreSavedRecipientsController controller,
}) {
  final nameController = TextEditingController(text: user.username.text);
  final emailController = TextEditingController(text: user.email?.text ?? '');
  final phoneController = TextEditingController(text: user.phone?.text ?? '');

  RxString selectedImage = ''.obs;

  if (user.profile.value.isNotEmpty) selectedImage.value = user.profile.value;

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Edit Contact", style: manRopeSemiBold.copyWith(fontSize: 16)),
            const SizedBox(height: 16),
            CustomTextField(controller: nameController, hintText: "Full Name"),
            const SizedBox(height: 12),
            CustomTextField(
                controller: emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 12),
            CustomTextField(
                controller: phoneController,
                hintText: "Phone",
                keyboardType: TextInputType.phone),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                pickImageBottomSheet(
                  (camera) => selectedImage.value = camera,
                  (gallery) => selectedImage.value = gallery,
                );
              },
              child: Obx(() => CircleAvatar(
                    radius: 35,
                    backgroundImage: selectedImage.value != ''
                        ? (selectedImage.value.startsWith('http')
                                ? NetworkImage(selectedImage.value)
                                : FileImage(File(selectedImage.value)))
                            as ImageProvider
                        : null,
                    backgroundColor: lightGrey,
                    child: selectedImage.value == ''
                        ? Icon(Icons.camera_alt)
                        : null,
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Cancel",
                    onPressed: () => Get.back(),
                    backgroundColor: lightGrey,
                    textColor: blackColor,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: "Update",
                    onPressed: () async {
                      String? uploadedImage;
                      if (selectedImage.value.isNotEmpty &&
                          !selectedImage.value.startsWith('http')) {
                        uploadedImage = await UploadFileService()
                            .fileUploadResult(uploadData: selectedImage.value);
                      }

                      final body = {
                        "id": user.id,
                        if (nameController.text.trim().isNotEmpty)
                          "name": nameController.text.trim(),
                        if (emailController.text.trim().isNotEmpty)
                          "email": emailController.text.trim(),
                        if (phoneController.text.trim().isNotEmpty)
                          "phone": phoneController.text.trim(),
                        if (uploadedImage != null) "picture": uploadedImage,
                      };

                      await ApiService().handleResponse(
                        apiMethod: () async => await ApiService()
                            .put("recipients/default/update", body),
                        onSuccess: (response) {
                          // Get.back();
                          controller.isLoading.toggle();
                          customErrorSnackBar(content: response['message']);
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
