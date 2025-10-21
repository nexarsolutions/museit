import 'dart:async';
import '../utils/dialog_utilities.dart';
import '../utils/custom_alert_dialog.dart';
import 'api_service.dart';

class UploadFileService {
  final ApiService _api = ApiService();

  /// Upload a single file (base function)
  Future<Map<String, dynamic>> uploadFile({
    required String filePath,
    String fieldName = 'file',
  }) async {
    return await _api.postMultipartFile(
      path: 'uploadFile',
      fieldName: fieldName,
      filePath: filePath,
    );
  }

  /// Handles upload with dialogs and returns the filename only
  Future<String?> fileUploadResult({required String uploadData}) async {
    final completer = Completer<String?>();

    await _api.handleResponse(
      loadingMsg: "Uploading...",
      apiMethod: () => uploadFile(filePath: uploadData),
      onSuccess: (uploadResponse) async {
        final fileName = uploadResponse['fileName'];
        if (fileName == null) {
          errorDialog(
            title: "Upload Failed",
            content: "fileName not returned by server.",
          );
          completer.complete(null);
        } else {
          completer.complete(fileName);
        }
      },
    );

    return completer.future;
  }

  /// ✅ Upload multiple images safely
  Future<List<String>> uploadMultipleImages(List<String> imagePaths) async {
    List<String> uploadedFiles = [];

    // Option 1 — Sequential (safe with loaders/dialogs)
    for (var path in imagePaths) {
      final fileName = await fileUploadResult(uploadData: path);
      if (fileName != null) uploadedFiles.add(fileName);
    }

    return uploadedFiles;
  }

  /// ✅ Option 2 — Parallel uploads (no UI dialogs per image)
  Future<List<String>> uploadMultipleImagesFast(List<String> imagePaths) async {
    try {
      final futures = imagePaths.map((path) => uploadFile(filePath: path));
      final responses = await Future.wait(futures);

      return responses.map((r) {
        final fileName = r['fileName'];
        if (fileName == null) {
          throw Exception('fileName missing in response');
        }
        return fileName as String;
      }).toList();
    } catch (e) {
      throw Exception('Error while uploading multiple images: $e');
    }
  }
}
