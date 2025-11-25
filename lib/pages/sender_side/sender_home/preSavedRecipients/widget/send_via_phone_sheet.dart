import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/widgets/custom_bottom_sheet.dart';
import 'package:musit/widgets/custom_text_field.dart';


void showSendViaPhoneSheet(
    {required BuildContext context,
    required Function(String phoneNumber) onPhoneSubmitted,
    bool isEmail = false}) {
  final phoneController = TextEditingController();
  final isPhoneEntered = false.obs;

  final formKey = GlobalKey<FormState>();

  customBottomSheet(
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Send via ${isEmail ? "Email" : "Phone Number"}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            if (!isEmail)
              CustomTextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                hintText: "Enter phone number",
                borderRadius: 12,
                isPrefixIcon: true,
                prefixIcon: const Icon(Icons.phone),
                validator: (value) => value!.trim().isEmpty
                    ? "Required"
                    : !GetUtils.isPhoneNumber(value)
                        ? "Enter valid number"
                        : null,
                onChanged: (value) {
                  isPhoneEntered.value = value.trim().isNotEmpty;
                },
              )
            else
              CustomTextField(
                controller: phoneController,
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter email",
                borderRadius: 12,
                isPrefixIcon: true,
                prefixIcon: const Icon(Icons.email),
                validator: (value) => value!.trim().isEmpty
                    ? "Required"
                    : !GetUtils.isEmail(value)
                        ? "Enter valid email"
                        : null,
                onChanged: (value) {
                  isPhoneEntered.value = value.trim().isNotEmpty;
                },
              ),
            const SizedBox(height: 20),

            /// Reactive submit button
            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Pass the phone number back to the parent screen
                      onPhoneSubmitted(phoneController.text.trim());
                      Get.back();
                    }
                  },
                  child: Text(
                    isPhoneEntered.value
                        ? "Continue"
                        : isEmail
                            ? "Enter Email"
                            : "Enter Number",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}
