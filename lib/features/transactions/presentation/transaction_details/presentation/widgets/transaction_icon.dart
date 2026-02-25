import 'package:flutter/material.dart';

class TransactionIcon extends StatelessWidget {
  const TransactionIcon({
    super.key,
    required this.category,
    required this.isIncome,
    this.size = 48,
    this.iconSize = 22,
  });

  final String category;
  final bool   isIncome;
  final double size;
  final double iconSize;

  IconData _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'food & dining':     return Icons.restaurant_rounded;
      case 'shopping':          return Icons.shopping_bag_rounded;
      case 'transport':         return Icons.directions_car_rounded;
      case 'bills & utilities': return Icons.receipt_long_rounded;
      case 'salary':            return Icons.work_rounded;
      case 'freelance':         return Icons.laptop_rounded;
      case 'entertainment':     return Icons.movie_rounded;
      case 'healthcare':        return Icons.local_hospital_rounded;
      case 'education':         return Icons.school_rounded;
      case 'investment':        return Icons.trending_up_rounded;
      default:                  return Icons.account_balance_wallet_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor   = isIncome
        ? const Color(0xFFDCFCE7)
        : const Color(0xFFF3F4F6);
    final iconColor = isIncome
        ? const Color(0xFF4CAF50)
        : const Color(0xFF4B5563);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        _iconForCategory(category),
        size: iconSize,
        color: iconColor,
      ),
    );
  }
}