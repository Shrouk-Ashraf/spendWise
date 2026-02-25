import 'package:flutter/material.dart';

class SearchBarField extends StatelessWidget {
  const SearchBarField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String>   onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search transactions...',
        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
        prefixIcon: const Icon(Icons.search_rounded,
            color: Color(0xFF9CA3AF)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}