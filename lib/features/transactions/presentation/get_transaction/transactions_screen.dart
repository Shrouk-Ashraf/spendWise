import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/config/di/di.dart';
import 'package:spendwise/config/routing/app_routes.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/features/transactions/data/models/transaction_model.dart';
import 'package:spendwise/features/transactions/presentation/get_transaction/cubit/get_transactions_cubit.dart';

import 'cubit/get_transactions_state.dart';
import 'widgets/search_bar_field.dart';
import 'widgets/filter_toggle.dart';
import 'widgets/summary_cards.dart';
import 'widgets/transactions_grouped_list.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  final _searchController = TextEditingController();
  String _filterType      = 'all'; // 'all' | 'income' | 'expense'
  String _searchQuery     = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ── Filter logic ──────────────────────────────────────────────────────────
  List<TransactionModel> _filtered(List<TransactionModel> all) {
    return all.where((t) {
      final matchesSearch = _searchQuery.isEmpty ||
          t.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.notes.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesType = _filterType == 'all' || t.type == _filterType;
      return matchesSearch && matchesType;
    }).toList();
  }

  // ── Group by date ─────────────────────────────────────────────────────────
  Map<String, List<TransactionModel>> _grouped(List<TransactionModel> list) {
    final Map<String, List<TransactionModel>> map = {};
    for (final t in list) {
      final key = _formatDate(t.date);
      map.putIfAbsent(key, () => []).add(t);
    }
    return map;
  }

  String _formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetTransactionsCubit>()..loadTransactions(),
      child: Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
        body: BlocBuilder<GetTransactionsCubit, TransactionsState>(
          builder: (context, state) {
            final filtered = _filtered(state.transactions);
            final grouped  = _grouped(filtered);

            final totalIncome = filtered
                .where((t) => t.isIncome)
                .fold(0.0, (s, t) => s + t.amount);
            final totalExpenses = filtered
                .where((t) => t.isExpense)
                .fold(0.0, (s, t) => s + t.amount);

            return CustomScrollView(
              slivers: [

                // ── Green Header + Search ───────────────────────
                _AllTransactionsHeader(
                  searchController: _searchController,
                  onSearch: (v) => setState(() => _searchQuery = v),
                ),

                SliverToBoxAdapter(
                  child: Column(
                    children: [

                      // ── Filter Toggle ─────────────────────────
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: FilterToggle(
                          selected: _filterType,
                          onChanged: (v) => setState(() => _filterType = v),
                        ),
                      ),

                      // ── Summary Cards ─────────────────────────
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SummaryCards(
                          totalIncome:   totalIncome,
                          totalExpenses: totalExpenses,
                        ),
                      ),

                      const Gap(24),

                      // ── Transactions List ─────────────────────
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: state.status == TransactionStatus.loading
                            ? const Center(child: CircularProgressIndicator(
                          color: Color(0xFF4CAF50),
                        ))
                            : TransactionsGroupedList(
                          grouped: grouped,
                          onTap: (id) => context.pushNamed(AppRoutes.transactionDetail,extra: id),
                        ),
                      ),

                      const Gap(32),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Private green header with search ─────────────────────────────────────────
class _AllTransactionsHeader extends StatelessWidget {
  const _AllTransactionsHeader({
    required this.searchController,
    required this.onSearch,
  });

  final TextEditingController searchController;
  final ValueChanged<String>  onSearch;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      backgroundColor: const Color(0xFF4CAF50),
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: const Color(0xFF4CAF50),
          padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white),
                  ),
                  const Text(
                    'All Transactions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Gap(12),
              SearchBarField(
                controller: searchController,
                onChanged: onSearch,
              ),
            ],
          ),
        ),
      ),
    );
  }
}