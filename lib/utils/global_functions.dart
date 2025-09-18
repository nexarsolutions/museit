import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:musit/constants/colors.dart';

///date picker
Future<void> selectDatePicker(
    TextEditingController controller, {
      bool selectPastDate = false, // 👈 new parameter
    }) async {
  DateTime selectedDate = DateTime.now();

  final DateTime? picked = await showDatePicker(
    context: Get.context!,
    initialDate: DateTime.now(),
    firstDate: selectPastDate ? DateTime(1900) : DateTime.now(), // 👈 agar past allowed h to 1900 se
    lastDate: selectPastDate ? DateTime.now() : DateTime(DateTime.now().year + 5), // 👈 agar past h to max today
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: blackColor,
            onPrimary: whiteColor,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
    controller.text = DateFormat('dd/MM/yyyy').format(selectedDate);
  }
}

/// time picker
void selectTimePicker(TextEditingController controller) async {
  TimeOfDay selectedTime = TimeOfDay.now();

  final TimeOfDay? picked = await showTimePicker(
    context: Get.context!,
    initialTime: selectedTime,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme:  ColorScheme.light(
            primary: blackColor,
            onPrimary: whiteColor,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null && picked != selectedTime) {
    selectedTime = picked;

    final now = DateTime.now();
    final time = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
    controller.text = DateFormat('hh:mm a').format(time);
  }
}

Future<String?> pickImage(ImageSource imageSource) async {
  final ImagePicker imagePicker = ImagePicker();
  final XFile? image = await imagePicker.pickImage(source: imageSource);

  if (image != null) {
    return image.path; // Return the image path
  } else {
    return null; // No image selected
  }
}

Future<String?> pickVideo(ImageSource source) async {
  final picker = ImagePicker();
  final XFile? video = await picker.pickVideo(source: source);
  return video?.path;
}

Future<String?> pickDocument() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
  );

  if (result != null && result.files.single.path != null) {
    return result.files.single.path!;
  }
  return null;
}
