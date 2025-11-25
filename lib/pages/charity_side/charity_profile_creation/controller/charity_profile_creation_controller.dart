// lib/modules/charity_profile_creation/controller/charity_profile_creation_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/globalModels/user_model.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/auth_service.dart';
import 'package:musit/services/upload_file_service.dart';
import 'package:musit/utils/dialog_utilities.dart';

import '../../../../globalModels/charity_model.dart';
import '../../../../main.dart';
import '../../charity_home/charity_home/charity_home_screen.dart';

class CharityProfileCreationController extends GetxController {
  // Step tracker
  final RxInt isSelected = 0.obs;

  // Form fields
  final organizationNameController = TextEditingController();
  final addressController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final accountTitleController = TextEditingController();
  final ownerIdController = TextEditingController();

  // Image paths (local)
  final registrationCertPath = ''.obs;
  final frontIdPath = ''.obs;
  final backIdPath = ''.obs;
  final facePath = ''.obs;

  // Model
  late CharityModel charityModel;

  // Services
  final UploadFileService _uploadService = UploadFileService();
  final ApiService _api = ApiService();
  final AuthService _authService = AuthService();

  var isLoading = false.obs;

  @override
  void onInit() {
    charityModel = CharityModel(
      organizationName: organizationNameController,
      address: addressController,
      bankName: bankNameController,
      accountNumber: accountNumberController,
      accountTitle: accountTitleController,
      ownerId: ownerIdController,
    );
    super.onInit();
  }

  // ✅ Step 1 validation
  bool validateStep1() {
    if (organizationNameController.text.trim().isEmpty) {
      errorDialog(
          title: "Missing Info", content: "Please enter organization name.");
      return false;
    }
    if (addressController.text.trim().isEmpty) {
      errorDialog(title: "Missing Info", content: "Please enter address.");
      return false;
    }
    if (registrationCertPath.value.isEmpty) {
      errorDialog(
          title: "Missing File",
          content: "Please upload registration certificate.");
      return false;
    }
    if (bankNameController.text.trim().isEmpty ||
        accountNumberController.text.trim().isEmpty ||
        accountTitleController.text.trim().isEmpty ||
        ownerIdController.text.trim().isEmpty) {
      errorDialog(
          title: "Missing Info", content: "Please fill all banking details.");
      return false;
    }
    return true;
  }

  // 🧠 Upload single image helper
  Future<String?> _uploadImage(String filePath) async {
    try {
      final uploadedUrl =
          await _uploadService.fileUploadResult(uploadData: filePath);
      return uploadedUrl;
    } catch (e) {
      errorDialog(title: "Upload Failed", content: e.toString());
      return null;
    }
  }

  // ✅ Step 1 submission
  Future<void> submitStep1() async {
    if (!validateStep1()) return;

    isLoading.value = true;
    try {
      final certUrl = await _uploadImage(registrationCertPath.value);
      if (certUrl == null)
        throw Exception("Registration certificate upload failed.");

      charityModel.registrationCertificate.value = certUrl;
      isSelected.value = 1;
    } catch (e) {
      errorDialog(title: "Error", content: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ Step 2 - Front ID
  Future<void> submitFrontId() async {
    if (frontIdPath.value.isEmpty) {
      errorDialog(
          title: "Missing File", content: "Please upload front ID image.");
      return;
    }
    isLoading.value = true;
    try {
      final url = await _uploadImage(frontIdPath.value);
      if (url == null) throw Exception("Front ID upload failed.");

      charityModel.frontId.value = url;
      isSelected.value = 2;
    } catch (e) {
      errorDialog(title: "Upload Failed", content: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ Step 3 - Back ID
  Future<void> submitBackId() async {
    if (backIdPath.value.isEmpty) {
      errorDialog(
          title: "Missing File", content: "Please upload back ID image.");
      return;
    }
    isLoading.value = true;
    try {
      final url = await _uploadImage(backIdPath.value);
      if (url == null) throw Exception("Back ID upload failed.");

      charityModel.backId.value = url;
      isSelected.value = 3;
    } catch (e) {
      errorDialog(title: "Upload Failed", content: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ Step 4 - Face Recognition & Final Submit
  Future<void> submitFace() async {
    if (facePath.value.isEmpty) {
      errorDialog(
          title: "Missing File",
          content: "Please upload face recognition photo.");
      return;
    }
    isLoading.value = true;
    try {
      final url = await _uploadImage(facePath.value);
      if (url == null) throw Exception("Face photo upload failed.");

      charityModel.faceRecognition.value = url;

      // 🧠 Submit final charity data to backend
      var data = charityModel.toJson();
      await _api.handleResponse(
        loadingMsg: "Submitting profile...",
        apiMethod: () => _authService.createCharityProfile(data),
        onSuccess: (response) async {
          UserModel currentUser = UserModel.fromJson(response['response']);
          String? token = userManager.cachedUser?.token;
          await userManager.clearUser();
          userManager.cachedUser = currentUser..token = token ?? '';
          Get.offAll(() => CharityHomeScreen());
          successDialog(
            title: "Success",
            content: "Charity profile created successfully!",
          );
        },
      );
    } catch (e) {
      errorDialog(title: "Submit Failed", content: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
