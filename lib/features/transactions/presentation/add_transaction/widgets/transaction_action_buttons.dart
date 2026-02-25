import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TransactionActionButtons extends StatelessWidget {
  const TransactionActionButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Color(0xFFD1D5DB)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
              ),
            ),
          ),
        ),
        const Gap(16),
        Expanded(
          child: ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}