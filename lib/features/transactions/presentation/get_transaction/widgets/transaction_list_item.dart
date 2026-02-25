import 'package:flutter/material.dart';
import 'package:spendwise/features/transactions/data/models/transaction_model.dart';


class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    super.key,
    required this.transaction,
    required this.onTap,
    this.showDivider = true,
  });

  final TransactionModel transaction;
  final VoidCallback     onTap;
  final bool             showDivider;

  IconData _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'food & dining':   return Icons.restaurant_rounded;
      case 'shopping':        return Icons.shopping_bag_rounded;
      case 'transport':       return Icons.directions_car_rounded;
      case 'bills & utilities': return Icons.receipt_long_rounded;
      case 'salary':          return Icons.work_rounded;
      case 'freelance':       return Icons.laptop_rounded;
      case 'entertainment':   return Icons.movie_rounded;
      case 'healthcare':      return Icons.local_hospital_rounded;
      default:                return Icons.account_balance_wallet_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.isIncome;
    final color    = isIncome
        ? const Color(0xFF4CAF50)
        : const Color(0xFF111827);
    final iconBg   = isIncome
        ? const Color(0xFFDCFCE7)
        : const Color(0xFFF3F4F6);
    final iconColor = isIncome
        ? const Color(0xFF4CAF50)
        : const Color(0xFF4B5563);

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Icon circle
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _iconForCategory(transaction.category),
                    size: 22,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 12),

                // Category + notes
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.category,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111827),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        transaction.notes.isEmpty
                            ? 'No notes'
                            : transaction.notes,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Amount
                Text(
                  '${isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 1, indent: 76, color: Color(0xFFF3F4F6)),
      ],
    );
  }
}