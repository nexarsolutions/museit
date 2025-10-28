// lib/modules/charity_side/charity_create_campaign/controller/charity_create_campaign_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/upload_file_service.dart';
import 'package:musit/utils/dialog_utilities.dart';

import '../../../../globalModels/charity_compaign_model.dart';

class CharityCreateCampaignController extends GetxController {
  // Form Controllers
  final compaignTitleController = TextEditingController();
  final monthlyAidGoalController = TextEditingController();
  final causeController = TextEditingController();
  // final goalAmountController = TextEditingController();
  // final bankNameController = TextEditingController();
  // final accountNumberController = TextEditingController();
  // final accountTitleController = TextEditingController();

  // final RxString selectedPlaylist = 'Umbrella'.obs;
  // final List<String> playlistList = [
  //   'Umbrella',
  //   'Sky',
  //   'Fallen to earth',
  //   'God Given',
  // ];

  final RxString pickedImagePath = ''.obs;

  // Services
  final UploadFileService _uploadService = UploadFileService();
  final ApiService _api = ApiService();
  final ImagePicker _picker = ImagePicker();

  late CharityCampaignModel campaignModel;
  var isLoading = false.obs;

  @override
  void onInit() {
    campaignModel = CharityCampaignModel(
      compaignTitle: compaignTitleController,
      monthlyAidGoal: monthlyAidGoalController,
      cause: causeController,
      // goalAmount: goalAmountController,
      // bankName: bankNameController,
      // accountNumber: accountNumberController,
      // accountTitle: accountTitleController,
      // playlist: selectedPlaylist,
      imageUrl: ''.obs,
    );
    super.onInit();
  }

  // Upload Image
  Future<String?> _uploadImage(String path) async {
    try {
      final uploadedUrl = await _uploadService.fileUploadResult(uploadData: path);
      return uploadedUrl;
    } catch (e) {
      errorDialog(title: "Upload Failed", content: e.toString());
      return null;
    }
  }

  // Validate fields
  bool _validateFields() {
    if (compaignTitleController.text.trim().isEmpty) {
      errorDialog(title: "Missing Field", content: "Please enter campaign title.");
      return false;
    }
    if (monthlyAidGoalController.text.trim().isEmpty) {
      errorDialog(title: "Missing Field", content: "Please enter monthly aid goal.");
      return false;
    }
    // if (selectedPlaylist.value.isEmpty) {
    //   errorDialog(title: "Missing Field", content: "Please select a playlist.");
    //   return false;
    // }
    if (causeController.text.trim().isEmpty) {
      errorDialog(title: "Missing Field", content: "Please enter campaign cause.");
      return false;
    }
    if (pickedImagePath.value.isEmpty) {
      errorDialog(title: "Missing Image", content: "Please upload campaign image.");
      return false;
    }
    // if (goalAmountController.text.trim().isEmpty) {
    //   errorDialog(title: "Missing Field", content: "Please enter goal amount.");
    //   return false;
    // }
    // if (bankNameController.text.trim().isEmpty ||
    //     accountNumberController.text.trim().isEmpty ||
    //     accountTitleController.text.trim().isEmpty) {
    //   errorDialog(title: "Missing Field", content: "Please fill all bank details.");
    //   return false;
    // }
    return true;
  }

  // Submit (Publish or Draft)
  Future<void> submitCampaign({required bool isPublish}) async {
    if (!_validateFields()) return;

    isLoading.value = true;
    try {
      // Upload Image First
      final imgUrl = await _uploadImage(pickedImagePath.value);
      if (imgUrl == null) throw Exception("Failed to upload image.");

      campaignModel.imageUrl.value = imgUrl;

      final body = campaignModel.toJson(isPublish: isPublish);

      await _api.handleResponse(
        loadingMsg: isPublish ? "Publishing campaign..." : "Saving draft...",
        apiMethod: () async =>await _api.post("campaign", body),
        onSuccess: (res) {
          successDialog(
            title: "Success",
            content: res["message"] ?? "Campaign created successfully!",
          );
          Get.back();
        },
      );
    } catch (e) {
      errorDialog(title: "Error", content: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
