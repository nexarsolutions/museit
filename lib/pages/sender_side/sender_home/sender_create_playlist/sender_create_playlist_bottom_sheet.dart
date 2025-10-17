import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/utils/validators.dart';
import 'package:musit/widgets/custom_bottom_sheet.dart';
import 'package:musit/widgets/custom_image_picker.dart';
import 'package:musit/widgets/custom_text_field.dart';

import '../../../../constants/global_list.dart';
import '../../../../utils/custom_alert_dialog.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../sender_add_songs/sender_add_songs_screen.dart';
import 'controller/sender_create_playlist_controller.dart';

void senderCreatePlaylistBottomSheet() {
  final controller = Get.put(SenderCreatePlaylistController());
  final formKey = GlobalKey<FormState>();

  customBottomSheet(
    child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Create Playlist',
              style: manRopeSemiBold.copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          Text('Playlist Title', style: manRopeSemiBold.copyWith(fontSize: 12)),
          SizedBox(height: 8),
          CustomTextField(
            controller: controller.playlistModel.title,
            hintText: 'Add Text',
            validator: validateIsEmpty,
          ),
          SizedBox(height: 16),
          Text('Select Purpose', style: manRopeSemiBold.copyWith(fontSize: 12)),
          SizedBox(height: 8),
          CustomDropDown<String>(
            maxHeight: 200,
            dropdownItems: playlistPurposes,
            value: controller.selectedPurpose.value != null &&
                    playlistPurposes.contains(controller.selectedPurpose.value)
                ? controller.selectedPurpose.value
                : null,
            onChanged: (value) {
              controller.selectedPurpose.value = value!;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select purpose';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Text('Upload Image', style: manRopeSemiBold.copyWith(fontSize: 12)),
          SizedBox(height: 8),
          CustomImagePicker(pickedImagePath: controller.playlistModel.image),
          SizedBox(height: 42),
          Center(
            child: CustomButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (controller.playlistModel.image.value.isEmpty) {
                    customAlertDialog(
                      'No image selected',
                      'Please upload a image before proceeding, as it is required to continue with this action.',
                    );
                    return;
                  }
                  Get.to(() => SenderAddSongsScreen());
                }
              },
              text: 'Add Songs',
            ),
          ),
        ],
      ),
    ),
  );
}
