import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// Assuming you have 'AppRoutes' for navigation, and your main 'AppColors' for styling

// --- 1. Loading Dialog ---

void loadingDialog({
  String message = "Processing...",
  bool isDismissible = false,
}) {
  if (Get.isDialogOpen == true) {
    Get.back(); // Close any existing dialog/snackbar first
  }

  Get.dialog(
    WillPopScope(
      onWillPop: () async => isDismissible,
      child: _ModernLoadingDialog(message: message),
    ),
    barrierDismissible: isDismissible,
  );
}

// --- 2. Error/Alert Dialog ---

void errorDialog({String title = "Error", required String content}) {
  if (Get.isSnackbarOpen || Get.isDialogOpen == true) {
    Get.back();
  }
  Get.dialog(
    _ModernAlertDialog(
      title: title,
      content: content,
      icon: Icons.error_outline_rounded,
      iconColor: Colors.red.shade600,
    ),
    barrierDismissible: true,
  );
}

// --- 2b. Error Dialog with Copyable Error Message ---

void errorDialogWithCopy({
  String title = "Error",
  required String content,
  String? errorDetails,
}) {
  if (Get.isSnackbarOpen || Get.isDialogOpen == true) {
    Get.back();
  }
  Get.dialog(
    _ErrorDialogWithCopy(
      title: title,
      content: content,
      errorDetails: errorDetails ?? content,
    ),
    barrierDismissible: true,
  );
}

// --- 3. Success Dialog (Optional, but highly recommended) ---

void successDialog({
  String title = "Success",
  required String content,
  Function()? onConfirm,
}) {
  if (Get.isSnackbarOpen || Get.isDialogOpen == true) {
    Get.back();
  }
  Get.dialog(
    _ModernAlertDialog(
      title: title,
      content: content,
      icon: Icons.check_circle_outline_rounded,
      iconColor: Colors.green.shade600,
      onConfirm: onConfirm,
    ),
    barrierDismissible: true,
  );
}

// --- 4. Confirmation Dialog ---

void confirmationDialog({
  String title = "Confirm",
  required String content,
  String confirmText = "Yes",
  String cancelText = "No",
  required Function() onConfirm,
  Function()? onCancel,
}) {
  if (Get.isSnackbarOpen || Get.isDialogOpen == true) {
    Get.back();
  }
  Get.dialog(
    _ModernConfirmationDialog(
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
    ),
    barrierDismissible: true,
  );
}

// Helper Widget for the Loading Dialog
class _ModernLoadingDialog extends StatelessWidget {
  final String message;
  const _ModernLoadingDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.cardColor, // Use a contrasting card color
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(greenColor),
              ),
              const SizedBox(height: 20),
              Text(message,
                  style: manRopeSemiBold, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper Widget for Error/Success/Alert Dialogs
class _ModernAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color iconColor;
  final Function()? onConfirm;

  const _ModernAlertDialog({
    required this.title,
    required this.content,
    required this.icon,
    required this.iconColor,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: context.theme
              .scaffoldBackgroundColor, // Use background for dialog content
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Icon(icon, size: 60, color: iconColor),
            const SizedBox(height: 15),

            // Title
            Text(title, style: manRopeSemiBold, textAlign: TextAlign.center),
            const SizedBox(height: 10),

            // Content/Message
            Text(content, style: manRopeSemiBold, textAlign: TextAlign.center),
            const SizedBox(height: 25),

            CustomButton(
              onPressed: () {
                Get.back();
                onConfirm?.call();
              },
              text: 'OK',
            ),
          ],
        ),
      ),
    );
  }
}

// Helper Widget for Confirmation Dialog
class _ModernConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final Function() onConfirm;
  final Function()? onCancel;

  const _ModernConfirmationDialog({
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Icon(
              Icons.help_outline_rounded,
              size: 60,
              color: greenColor,
            ),
            const SizedBox(height: 15),

            // Title
            Text(title, style: manRopeSemiBold, textAlign: TextAlign.center),
            const SizedBox(height: 10),

            // Content/Message
            Text(content, style: manRopeSemiBold, textAlign: TextAlign.center),
            const SizedBox(height: 25),

            // Buttons Row
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      Get.back();
                      onCancel?.call();
                    },
                    text: cancelText,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      Get.back();
                      onConfirm();
                    },
                    text: confirmText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Helper Widget for Error Dialog with Copyable Text
class _ErrorDialogWithCopy extends StatelessWidget {
  final String title;
  final String content;
  final String errorDetails;

  const _ErrorDialogWithCopy({
    required this.title,
    required this.content,
    required this.errorDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 500),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Icon(
              Icons.error_outline_rounded,
              size: 60,
              color: Colors.red.shade600,
            ),
            const SizedBox(height: 15),

            // Title
            Text(
              title,
              style: manRopeSemiBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Content/Message
            Text(
              content,
              style: manRopeSemiBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),

            // Error Details Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Error Details:',
                        style: manRopeSemiBold.copyWith(fontSize: 14),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 20),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: errorDetails));
                          Get.snackbar(
                            'Copied',
                            'Error details copied to clipboard',
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 2),
                          );
                        },
                        tooltip: 'Copy error details',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      minHeight: 100,
                      maxHeight: 200,
                    ),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      child: SelectableText(
                        errorDetails.isEmpty ? 'No error details available' : errorDetails,
                        style: manRope.copyWith(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // OK Button
            CustomButton(
              onPressed: () {
                Get.back();
              },
              text: 'OK',
            ),
          ],
        ),
      ),
    );
  }
}
