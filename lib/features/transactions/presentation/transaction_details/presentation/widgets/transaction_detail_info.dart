import 'package:flutter/material.dart';
import 'package:spendwise/features/transactions/data/models/transaction_model.dart';


class TransactionDetailInfo extends StatelessWidget {
  const TransactionDetailInfo({super.key, required this.transaction});
  final TransactionModel transaction;

  String _formatDate(DateTime date) {
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday',
      'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${weekdays[date.weekday - 1]}, '
        '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.label_rounded,
            iconBg: const Color(0xFFDBEAFE),
            iconColor: const Color(0xFF2196F3),
            label: 'Category',
            value: transaction.category,
            hasDivider: true,
          ),
          _InfoRow(
            icon: Icons.calendar_today_rounded,
            iconBg: const Color(0xFFF3E8FF),
            iconColor: const Color(0xFF9333EA),
            label: 'Date',
            value: _formatDate(transaction.date),
            hasDivider: true,
          ),
          _InfoRow(
            icon: Icons.description_outlined,
            iconBg: const Color(0xFFFFF7ED),
            iconColor: const Color(0xFFF97316),
            label: 'Notes',
            value: transaction.notes.isEmpty
                ? 'No notes available'
                : transaction.notes,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.value,
    this.hasDivider = false,
  });

  final IconData icon;
  final Color    iconBg;
  final Color    iconColor;
  final String   label;
  final String   value;
  final bool     hasDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 22, color: iconColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (hasDivider)
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
      ],
    );
  }
}