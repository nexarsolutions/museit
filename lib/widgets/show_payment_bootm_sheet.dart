import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/widgets/custom_bottom_sheet.dart';
import 'package:musit/widgets/custom_text_field.dart';
void showPaymentBottomSheet({
  required BuildContext context,
  required Function(double amount) onAmountSubmitted,
}) {
  final amountController = TextEditingController();
  final RxDouble selectedAmount = 0.0.obs;
  final formKey = GlobalKey<FormState>();

  final List<double> presetAmounts = [10, 20, 50, 100, 200];

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
              "Donate",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

            /// 💸 Preset Amounts
            Obx(() => Wrap(
              spacing: 10,
              runSpacing: 10,
              children: presetAmounts.map((amount) {
                final isSelected = selectedAmount.value == amount;

                return ChoiceChip(
                  label: Text("£$amount"),
                  selected: isSelected,
                  selectedColor: Colors.black,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (_) {
                    selectedAmount.value = amount;
                    amountController.text = amount.toString();
                  },
                );
              }).toList(),
            )),

            const SizedBox(height: 20),

            /// ✍️ Custom Amount
            CustomTextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              hintText: "Or enter custom amount",
              borderRadius: 12,
              isPrefixIcon: true,
              prefixIcon: const Icon(Icons.currency_pound),
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) {
                  return "Amount is required";
                }

                final amount = double.tryParse(text);
                if (amount == null) return "Enter valid number";
                if (amount <= 0) return "Amount must be greater than zero";
                if (amount > 1000000) return "Amount too large";

                return null;
              },
              onChanged: (value) {
                selectedAmount.value = double.tryParse(value) ?? 0.0;
              },
            ),

            const SizedBox(height: 24),

            /// 🚀 Submit Button
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
                      onAmountSubmitted(selectedAmount.value);
                    }
                  },
                  child: Text(
                    selectedAmount.value > 0 ? "Continue" : "Submit",
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
