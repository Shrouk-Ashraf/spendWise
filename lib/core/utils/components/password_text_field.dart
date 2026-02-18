import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
class PasswordField extends StatefulWidget {
  const PasswordField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
   bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !showPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: '••••••••',
        prefixIcon: const Icon(
          Icons.lock_outline,
          size: 20,
          color: AppColors.gray400,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            showPassword ? Icons.visibility_off : Icons.visibility,
            size: 20,
            color: AppColors.gray400,
          ),
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),

      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }
}