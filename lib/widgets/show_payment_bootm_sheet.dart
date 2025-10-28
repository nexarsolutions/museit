import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/widgets/custom_bottom_sheet.dart';
import 'package:musit/widgets/custom_text_field.dart';

import '../../../../../utils/custom_error_snack_bar.dart';

void showPaymentBottomSheet({
  required BuildContext context,
  required Function(double amount) onAmountSubmitted,
}) {
  final amountController = TextEditingController();
  final isAmountEntered = false.obs;
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
            const Text(
              "Payment",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              hintText: "Enter amount",
              borderRadius: 12,
              isPrefixIcon: true,
              prefixIcon: const Icon(Icons.attach_money),
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) {
                  return "Amount is required";
                }

                final amount = double.tryParse(text);
                if (amount == null) {
                  return "Please enter a valid number";
                }

                if (amount <= 0) {
                  return "Amount must be greater than zero";
                }

                if (amount > 1000000) {
                  return "Amount too large";
                }

                return null; // ✅ All good
              },
              onChanged: (value) {
                isAmountEntered.value = value.trim().isNotEmpty;
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
                      onAmountSubmitted(
                          double.tryParse(amountController.text.trim()) ?? 0.0);
                      Get.back();
                    }
                  },
                  child: Text(
                    isAmountEntered.value ? "Continue" : "Enter Amount",
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
