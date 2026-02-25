import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/features/transactions/data/models/transaction_model.dart';
import 'transaction_icon.dart';

class TransactionAmountCard extends StatelessWidget {
  const TransactionAmountCard({super.key, required this.transaction});
  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final isIncome     = transaction.isIncome;
    final amountColor  = isIncome
        ? const Color(0xFF4CAF50)
        : const Color(0xFF111827);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          TransactionIcon(
            category: transaction.category,
            isIncome: isIncome,
            size: 80,
            iconSize: 36,
          ),
          const Gap(16),
          Text(
            isIncome ? 'Income' : 'Expense',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          const Gap(8),
          Text(
            '${isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}