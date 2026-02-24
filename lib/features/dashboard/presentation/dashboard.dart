import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/config/routing/app_routes.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:spendwise/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:spendwise/features/dashboard/presentation/widgets/quick_actions.dart';
import 'package:spendwise/features/dashboard/presentation/widgets/recent_transactions.dart';

import '../data/models/transaction_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double totalBalance = 5250.00;
    const double monthlyExpenses = 1475.50;
    const double monthlySavings = 850.00;

    final recentTransactions = [
      Transaction(
        id: '1',
        category: 'Groceries',
        amount: 85.50,
        date: DateTime.now().subtract(Duration(days: 1)),
        type: 'expense',
        icon: Icons.shopping_bag_outlined,
      ),
      Transaction(
        id: '2',
        category: 'Salary',
        amount: 3500.00,
        date: DateTime.now().subtract(Duration(days: 2)),
        type: 'income',
        icon: Icons.business_center_outlined,
      ),
      Transaction(
        id: '3',
        category: 'Restaurant',
        amount: 45.20,
        date: DateTime.now().subtract(Duration(days: 3)),
        type: 'expense',
        icon: Icons.restaurant_outlined,
      ),
      Transaction(
        id: '4',
        category: 'Gas',
        amount: 60.00,
        date: DateTime.now().subtract(Duration(days: 4)),
        type: 'expense',
        icon: Icons.directions_car_outlined,
      ),
      Transaction(
        id: '5',
        category: 'Freelance',
        amount: 500.00,
        date: DateTime.now().subtract(Duration(days: 5)),
        type: 'income',
        icon: Icons.account_balance_wallet_outlined,
      ),
    ];

    return Scaffold(
      backgroundColor:AppColors.lightBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            DashboardHeader(),

            // Balance Card
            BalanceCard(totalBalance: totalBalance, monthlyExpenses: monthlyExpenses, monthlySavings: monthlySavings),

            // Recent Transactions
            RecentTransactions(recentTransactions: recentTransactions),

            // Quick Actions
            QuickActions()

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(AppRoutes.addTransaction),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
    );
  }


}

