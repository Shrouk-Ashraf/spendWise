import 'package:flutter/material.dart';
import 'section_card.dart';
import 'field_label.dart';

class NotesField extends StatelessWidget {
  const NotesField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldLabel('Notes (Optional)'),
          const SizedBox(height: 12),
          TextFormField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Add a note...',
              prefixIcon: const Padding(
                padding: EdgeInsets.only(bottom: 48),
                child: Icon(Icons.description_outlined,
                    size: 20, color: Color(0xFF9CA3AF)),
              ),
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
          ),
        ],
      ),
    );
  }
}