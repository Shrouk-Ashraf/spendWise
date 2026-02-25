import 'package:flutter/material.dart';

class FilterToggle extends StatelessWidget {
  const FilterToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
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
        children: ['all', 'income', 'expense'].map((type) {
          final isActive = selected == type;
          final label = type == 'all'
              ? 'All'
              : type == 'income'
              ? 'Income'
              : 'Expenses';

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF4CAF50)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isActive
                        ? Colors.white
                        : const Color(0xFF6B7280),
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