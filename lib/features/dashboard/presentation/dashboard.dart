import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double totalBalance = 5250.00;
    const double monthlyExpenses = 1475.50;
    const double monthlySavings = 850.00;

    // Mock data - replace with your actual data source
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
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello, Alex!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'Welcome back to Spend Wise',
                        style: TextStyle(
                          color: Colors.green[100],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                // Balance Card
                Transform.translate(
                  offset: const Offset(0, -24),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: Colors.grey[100]!),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Balance',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            '\$${totalBalance.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(16),
                          // Quick Summary
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.red[100],
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.trending_down,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                    const Gap(12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Expenses',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 11,
                                          ),
                                        ),
                                        const Gap(2),
                                        Text(
                                          '\$${monthlyExpenses.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.green[100],
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.savings_outlined,
                                        color: Color(0xFF4CAF50),
                                        size: 20,
                                      ),
                                    ),
                                    const Gap(12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Savings',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 11,
                                          ),
                                        ),
                                        const Gap(2),
                                        Text(
                                          '\$${monthlySavings.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Recent Transactions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recent Transactions',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go('/transactions'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF4CAF50),
                                fontWeight: FontWeight.w500,
                              ),
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
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recentTransactions.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            color: Colors.grey[100],
                          ),
                          itemBuilder: (context, index) {
                            final transaction = recentTransactions[index];
                            return InkWell(
                              onTap: () => context.go('/transaction/${transaction.id}'),
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
                                        transaction.icon,
                                        color: transaction.type == 'income'
                                            ? const Color(0xFF4CAF50)
                                            : Colors.grey[600],
                                        size: 24,
                                      ),
                                    ),
                                    const Gap(16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transaction.category,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                              fontSize: 15,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Gap(4),
                                          Text(
                                            _formatDate(transaction.date),
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[500],
                                            ),
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
                                            ? const Color(0xFF4CAF50)
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
                ),

                const Gap(32),

                // Quick Actions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const Gap(16),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.2,
                        children: [
                          _QuickActionCard(
                            icon: Icons.trending_down,
                            iconColor: Colors.red,
                            backgroundColor: Colors.green[100]!,
                            label: 'Add Expense',
                            onTap: () => context.go('/add-transaction'),
                          ),
                          _QuickActionCard(
                            icon: Icons.trending_up,
                            iconColor: const Color(0xFF4CAF50),
                            backgroundColor: Colors.green[100]!,
                            label: 'Add Income',
                            onTap: () => context.go('/add-transaction?type=income'),
                          ),
                          _QuickActionCard(
                            icon: Icons.receipt_outlined,
                            iconColor: const Color(0xFF2196F3),
                            backgroundColor: Colors.blue[100]!,
                            label: 'Budgets',
                            onTap: () => context.go('/budgets'),
                          ),
                          _QuickActionCard(
                            icon: Icons.savings_outlined,
                            iconColor: Colors.purple,
                            backgroundColor: Colors.purple[100]!,
                            label: 'Savings',
                            onTap: () => context.go('/savings'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Gap(120), // Space for bottom nav and FAB
              ],
            ),
          ),

          // Floating Action Button
          Positioned(
            bottom: 96,
            right: 24,
            child: FloatingActionButton(
              onPressed: () => context.go('/add-transaction'),
              backgroundColor: const Color(0xFF4CAF50),
              child: const Icon(
                Icons.add,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}';
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const Gap(8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Transaction model
class Transaction {
  final String id;
  final String category;
  final double amount;
  final DateTime date;
  final String type;
  final IconData icon;

  Transaction({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.type,
    required this.icon,
  });
}