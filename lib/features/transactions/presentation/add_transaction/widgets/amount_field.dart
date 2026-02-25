import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spendwise/features/transactions/presentation/add_transaction/widgets/field_label.dart';
import 'package:spendwise/features/transactions/presentation/add_transaction/widgets/section_card.dart';

class AmountField extends StatelessWidget {
  const AmountField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldLabel('Amount'),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '\$',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                  decoration: const InputDecoration(
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD1D5DB),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter an amount';
                    if (double.tryParse(v) == null) return 'Invalid amount';
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}