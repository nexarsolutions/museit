import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../globalModels/user_model.dart';
import '../../../../../main.dart';
import '../../../../../services/api_service.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/upload_file_service.dart';
import '../../../../../utils/dialog_utilities.dart';

class EditProfileController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isCurrentPasswordHidden = true.obs;
  var isNewPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  ///services
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  final UploadFileService _fileService = UploadFileService();

  ///get user info by id
  Future<UserModel?> getUserInfoById() async {
    try {
      UserModel? newUser;

      await _apiService.handleGetResponse(
        apiMethod: () => _authService.getUserInfoById(
            userId: userManager.cachedUser?.id ?? (-1)),
        onSuccess: (response) {
          // Get the raw value of the 'response' key
          final dynamic rawUserResponse = response['response'];
          // Safely check if it's a Map before attempting to parse
          if (rawUserResponse is Map<String, dynamic>) {
            final Map<String, dynamic> userResponse = rawUserResponse;
            newUser = UserModel.fromJson(userResponse);
          } else {
            // Log a warning if the 'response' key exists but is not a Map
            // newUser will remain null, which is the desired behavior for "no user data found"
            throw Exception(
                'Warning: API response for user info is not a Map or is missing. Received: $rawUserResponse');
          }
        },
        onError: (error) {
          throw Exception(error);
        },
      );

      return newUser;
    } catch (e) {
      rethrow;
    }
  }

  // updateProfile
  void updateProfile({required UserModel user}) async {
    loadingDialog();
    var data = user.toUpdateCustomerJson();

    if (user.profile.value != '' &&
        (user.profile.value.contains('/') ||
            user.profile.value.contains('file'))) {
      String? image =
          await _fileService.fileUploadResult(uploadData: user.profile.value);
      if (image != null) {
        data.addAll({'profile': image});
      } else {
        Get.back();
        return;
      }
    }

    Get.back(); //close loading dialog

    await _apiService.handleResponse(
      loadingMsg: "Updating...",
      apiMethod: () => _authService.updateProfile(data),
      onSuccess: (response) async {
        UserModel newUser = UserModel.fromJson(response['response'])
          ..token = userManager.cachedUser?.token;
        // await Future.delayed(const Duration(milliseconds: 800));
        await userManager.clearUser();
        userManager.cachedUser = newUser;
        Get.back();
        successDialog(content: response['message']);
      },
    );
  }

  void updatePassword() async {
    var data = {
      "password": currentPasswordController.text.trim(),
      "newPassword": newPasswordController.text.trim(),
    };

    await _apiService.handleResponse(
      loadingMsg: "Updating...",
      apiMethod: () => _authService.updatePassword(data),
      onSuccess: (response) async {
        // customPrint("Update Password: $response");
        //wait for loading dialog to close
        // await Future.delayed(const Duration(milliseconds: 800));
        Get.back(); //close dialog
        successDialog(content: response['message']);
      },
    );
  }
}
