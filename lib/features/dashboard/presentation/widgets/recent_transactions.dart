import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/config/routing/app_routes.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/features/transactions/data/models/transaction_model.dart';
import '../../../../core/theme/app_text_styles.dart';

class RecentTransactions extends StatelessWidget {
  final List<TransactionModel> recentTransactions;
  const RecentTransactions({super.key, required this.recentTransactions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: AppTextStyles.text18SemiBoldBlack,
              ),
              TextButton(
                onPressed: () => context.pushNamed(AppRoutes.transactions),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'View All',
                  style: AppTextStyles.text13MediumPrimary,
                ),
              ),
            ],
          ),
          const Gap(16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentTransactions.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: Colors.grey[100]),
              itemBuilder: (context, index) {
                final transaction = recentTransactions[index];
                return InkWell(
                  onTap: () =>context.pushNamed(AppRoutes.transactionDetail,
                      extra:transaction.id),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: transaction.type == 'income'
                                ? Colors.green[100]
                                : Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            transaction.categoryIcon,
                            color: transaction.type == 'income'
                                ? AppColors.primary
                                : Colors.grey[600],
                            size: 24,
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.category,
                                style: AppTextStyles.text15MediumBlack ,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Gap(4),
                              Text(
                                _formatDate(transaction.date),
                                style: AppTextStyles.text13RegularGrey500,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${transaction.type == 'income' ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: transaction.type == 'income'
                                ? AppColors.primary
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }
}
