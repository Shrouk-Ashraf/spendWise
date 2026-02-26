import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/config/di/di.dart';
import 'package:spendwise/config/routing/app_routes.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:spendwise/features/dashboard/presentation/widgets/app_drawer.dart';
import 'package:spendwise/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:spendwise/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:spendwise/features/dashboard/presentation/widgets/quick_actions.dart';
import 'package:spendwise/features/dashboard/presentation/widgets/recent_transactions.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
      // Load recent transactions when the dashboard is first displayed
      context.read<DashboardCubit>().loadRecent();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
      drawer: const AppDrawer(),
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return

              SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  DashboardHeader(
                    onMenuTap: () => Scaffold.of(context).openDrawer(),
                  ),

                  // Balance Card
                  BalanceCard(totalBalance: state.balance,
                      monthlyExpenses: state.totalExpenses,
                      monthlySavings: state.totalIncome),

                  // Recent Transactions
                  state.status == DashboardStatus.loading ? const Center(child: CircularProgressIndicator()) :
                  state.status == DashboardStatus.error ? Center(child: Text(state.errorMessage ?? 'An error occurred')) :
                  RecentTransactions(recentTransactions: state.recentTransactions),

                  // Quick Actions
                  QuickActions()

                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(AppRoutes.addTransaction).then((_){
              debugPrint('Returned from Add Transaction, refreshing dashboard...');
              if (!mounted) return;
              context.read<DashboardCubit>().loadRecent();});
            },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, size: 28, color: Colors.white),
        ),
      );
  }
}

