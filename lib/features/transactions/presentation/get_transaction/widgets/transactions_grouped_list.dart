import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/features/transactions/data/models/transaction_model.dart';

import 'transaction_list_item.dart';

class TransactionsGroupedList extends StatelessWidget {
  const TransactionsGroupedList({
    super.key,
    required this.grouped,
    required this.onTap,
  });

  final Map<String, List<TransactionModel>> grouped;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    if (grouped.isEmpty) return const _EmptyState();

    return Column(
      children: grouped.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Date label ──────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 10),
                child: Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),

              // ── Transactions card ────────────────────────────
              Container(
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
                  children: entry.value.asMap().entries.map((e) {
                    final isLast = e.key == entry.value.length - 1;
                    return TransactionListItem(
                      transaction: e.value,
                      showDivider: !isLast,
                      onTap: () => onTap(e.value.id),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Icon(Icons.receipt_long_outlined,
              size: 48, color: Color(0xFFD1D5DB)),
          Gap(12),
          Text(
            'No transactions found',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}