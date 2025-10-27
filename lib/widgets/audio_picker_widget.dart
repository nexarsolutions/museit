import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:musit/services/upload_file_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/app_enums.dart';

class AudioPickerWidget extends StatefulWidget {
  final Function(List<Map<AudioKey, dynamic>> uploadedFileNames)
      onUploadComplete;

  const AudioPickerWidget({
    super.key,
    required this.onUploadComplete,
  });

  @override
  State<AudioPickerWidget> createState() => _AudioPickerWidgetState();
}

class _AudioPickerWidgetState extends State<AudioPickerWidget> {
  List<Map<AudioKey, dynamic>> pickedAudioPaths = [];
  bool isUploading = false;

  Future<void> pickAndUploadAudios() async {
    try {
      // 🛡️ Request permission first
      if (Platform.isAndroid) {
        final status = await _requestStoragePermission();
        if (!status) {
          Get.snackbar(
            'Permission Denied',
            'Please allow file access to pick audio.',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
      }

      // 1️⃣ Pick multiple audio files
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav', 'm4a', 'aac'],
      );

      if (result == null || result.files.isEmpty) return;

      setState(() {
        pickedAudioPaths = result.files
            .where((f) => f.path != null)
            .map((f) => {
                  AudioKey.path: f.path!,
                  AudioKey.name: f.name,
                })
            .toList();
      });

      // 2️⃣ Start uploading automatically
      await uploadAudios();
    } catch (e) {
      customErrorSnackBar(content: 'Failed to pick files: $e');
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (await Permission.storage.isGranted ||
        await Permission.audio.isGranted ||
        await Permission.mediaLibrary.isGranted) {
      return true;
    }

    // For Android 13+, check specific audio/media permission
    if (await Permission.audio.request().isGranted ||
        await Permission.mediaLibrary.request().isGranted ||
        await Permission.storage.request().isGranted) {
      return true;
    }

    return false;
  }

  Future<void> uploadAudios() async {
    if (pickedAudioPaths.isEmpty) return;

    setState(() => isUploading = true);
    final uploadService = UploadFileService();
    List<Map<AudioKey, dynamic>> uploadedFileNames = [];

    try {
      for (final audioPath in pickedAudioPaths) {
        final fileName = await uploadService.fileUploadResult(
            uploadData: audioPath[AudioKey.path]);
        if (fileName != null) {
          uploadedFileNames.add({
            AudioKey.path: fileName,
            AudioKey.name: audioPath[AudioKey.name]
          });
        } else {
          customErrorSnackBar(
              content: "Failed to upload ${audioPath[AudioKey.name]}");
        }
      }

      if (uploadedFileNames.isNotEmpty) {
        widget.onUploadComplete(uploadedFileNames);
        customErrorSnackBar(
            content:
                'Uploaded ${uploadedFileNames.length} file(s) successfully!');
      }
    } catch (e) {
      customErrorSnackBar(content: 'Upload failed: $e');
    } finally {
      // 3️⃣ Reset for reuse
      setState(() {
        pickedAudioPaths = [];
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 130,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8C7FAC).withValues(alpha: 0.15),
            const Color(0xFF7695CA).withValues(alpha: 0.15),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(4),
        decoration: DottedDecoration(
          color: Colors.blueAccent,
          strokeWidth: 1.2,
          shape: Shape.box,
          dash: const [3, 5],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isUploading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Uploading...',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: pickAndUploadAudios,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/upload_icon.png',
                        height: 30,
                        width: 30,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 13),
                      const Text(
                        'Upload Audio',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
