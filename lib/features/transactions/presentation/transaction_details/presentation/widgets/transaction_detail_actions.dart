import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TransactionDetailActions extends StatelessWidget {
  const TransactionDetailActions({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_rounded, size: 20),
            label: const Text(
              'Edit',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        const Gap(16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_rounded, size: 20),
            label: const Text(
              'Delete',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}