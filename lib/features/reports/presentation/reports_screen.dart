import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/features/reports/presentation/widgets/income_expenses_chart.dart';
import 'package:spendwise/features/reports/presentation/widgets/spending_pie_chart.dart';
import 'package:spendwise/features/reports/presentation/widgets/state_card.dart';
import 'package:spendwise/features/reports/presentation/widgets/time_frame_toggle.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';


class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _timeframe = 'monthly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title:  Text(
          'Reports & Analytics',
          style: AppTextStyles.text20SemiBoldDarkBlue,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Timeframe Toggle ──────────────────────────────────
                  TimeframeToggle(
                    selected: _timeframe,
                    onChanged: (v) => setState(() => _timeframe = v),
                  ),

                  const Gap(24),
                  IncomeExpensesChart(),

                  const Gap(24),

                  SpendingPieChart(),


                  const Gap(24),

                  // ── Summary Stats Grid ────────────────────────────────
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: const [
                      StatCard(
                        label: 'Total Income',
                        value: '\$2,650',
                        valueColor: AppColors.primary,
                        subtitle: 'This month',
                      ),
                      StatCard(
                        label: 'Total Expenses',
                        value: '\$1,800',
                        valueColor: AppColors.redColor,
                        subtitle: 'This month',
                      ),
                      StatCard(
                        label: 'Net Savings',
                        value: '\$850',
                        valueColor: AppColors.lightBlueColor,
                        subtitle: 'This month',
                      ),
                      StatCard(
                        label: 'Avg. Daily',
                        value: '\$106',
                        valueColor: AppColors.darkBlue,
                        subtitle: 'Spending',
                      ),
                    ],
                  ),

                  const Gap(32),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



