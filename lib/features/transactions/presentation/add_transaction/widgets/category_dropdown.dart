import 'package:flutter/material.dart';
import 'section_card.dart';
import 'field_label.dart';

const List<String> categories = [
  'Food & Dining',
  'Shopping',
  'Transport',
  'Bills & Utilities',
  'Entertainment',
  'Healthcare',
  'Education',
  'Salary',
  'Freelance',
  'Investment',
  'Other',
];

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldLabel('Category'),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: selected,
            onChanged: (v) => onChanged(v!),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: Color(0xFF4CAF50), width: 2),
              ),
            ),
            items: categories
                .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                .toList(),
          ),
        ],
      ),
    );
  }
}