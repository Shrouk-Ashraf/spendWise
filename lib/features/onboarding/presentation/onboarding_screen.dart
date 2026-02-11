import 'package:flutter/material.dart';
import 'package:spendwise/core/theme/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.account_balance_wallet_outlined,color: Colors.white,),
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to SpendWise',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Text(
              'Your personal finance companion',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

          ],
        ),
      ),
    );
  }
}
