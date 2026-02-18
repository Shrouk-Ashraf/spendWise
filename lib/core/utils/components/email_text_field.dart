
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: 'your@email.com',
        prefixIcon:  Icon(
          Icons.mail_outline,
          size: 20,
          color: AppColors.gray400,
        ),

      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!value.contains('@')||!value.endsWith('.com')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}