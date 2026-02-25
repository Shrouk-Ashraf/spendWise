import 'package:flutter/material.dart';

class TransactionTypeToggle extends StatelessWidget {
  const TransactionTypeToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: ['expense', 'income'].map((type) {
          final isActive = selected == type;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF4CAF50) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isActive
                      ? [
                    BoxShadow(
                      color: const Color(0xFF4CAF50).withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                      : [],
                ),
                child: Text(
                  type == 'expense' ? 'Expense' : 'Income',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isActive ? Colors.white : const Color(0xFF6B7280),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}