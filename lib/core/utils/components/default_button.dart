
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/core/theme/app_text_styles.dart';
class DefaultButton extends StatefulWidget {
  const DefaultButton({super.key, required this.onPressed, required this.label});

  final VoidCallback onPressed;
  final String label;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.r)),
            color:AppColors.primary,
            shadows: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 16.r,
                offset: const Offset(0, 6),
              ),
            ],

          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child:  Text(
            widget.label,
            textAlign: TextAlign.center,
            style: AppTextStyles.text16MediumWhite,
          ),
        ),
      ),
    );
  }
}