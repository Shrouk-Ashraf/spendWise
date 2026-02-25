import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SummaryCards extends StatelessWidget {
  const SummaryCards({
    super.key,
    required this.totalIncome,
    required this.totalExpenses,
  });

  final double totalIncome;
  final double totalExpenses;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            icon: Icons.trending_up_rounded,
            iconColor: const Color(0xFF4CAF50),
            iconBg: const Color(0xFFDCFCE7),
            label: 'Income',
            amount: totalIncome,
            amountColor: const Color(0xFF4CAF50),
          ),
        ),
        const Gap(16),
        Expanded(
          child: _SummaryCard(
            icon: Icons.trending_down_rounded,
            iconColor: const Color(0xFFEF4444),
            iconBg: const Color(0xFFFEE2E2),
            label: 'Expenses',
            amount: totalExpenses,
            amountColor: const Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.amount,
    required this.amountColor,
  });

  final IconData icon;
  final Color    iconColor;
  final Color    iconBg;
  final String   label;
  final double   amount;
  final Color    amountColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const Gap(8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}