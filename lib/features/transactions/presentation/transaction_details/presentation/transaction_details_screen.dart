import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/config/di/di.dart';
import 'package:spendwise/features/transactions/presentation/transaction_details/cubit/transaction_details_cubit.dart';
import 'package:spendwise/features/transactions/presentation/transaction_details/cubit/transaction_details_state.dart';
import 'widgets/transaction_amount_card.dart';
import 'widgets/transaction_detail_actions.dart';
import 'widgets/transaction_detail_info.dart';

class TransactionDetailScreen extends StatelessWidget {
  final String id;
  const TransactionDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TransactionDetailCubit>()..loadTransaction(id),
      child: const _TransactionDetailView(),
    );
  }
}

class _TransactionDetailView extends StatelessWidget {
  const _TransactionDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionDetailCubit, TransactionDetailState>(
      listener: (context, state) {
        // ── Deleted → go back to dashboard ──────────────────────
        if (state.status == TransactionDetailStatus.deleted) {
          context.pop();
        }

        // ── Error → show snackbar ────────────────────────────────
        if (state.status == TransactionDetailStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Something went wrong'),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      builder: (context, state) {
        // ── Loading ──────────────────────────────────────────────
        if (state.status == TransactionDetailStatus.loading ||
            state.status == TransactionDetailStatus.initial) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4CAF50),
              ),
            ),
          );
        }

        // ── Error ────────────────────────────────────────────────
        if (state.status == TransactionDetailStatus.error) {
          return _ErrorView(message: state.errorMessage ?? 'Error');
        }

        // ── Success ──────────────────────────────────────────────
        final transaction = state.transaction!;
        return Scaffold(
          backgroundColor: const Color(0xFFF9FAFB),
          body: CustomScrollView(
            slivers: [
              _TransactionDetailAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      TransactionAmountCard(transaction: transaction),
                      const Gap(24),
                      TransactionDetailInfo(transaction: transaction),
                      const Gap(32),
                      TransactionDetailActions(
                        onEdit: () {
                          // TODO: navigate to edit screen
                        },
                        onDelete: () => _confirmDelete(context, transaction.id),
                      ),
                      const Gap(32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Delete confirmation dialog ────────────────────────────────────────────
  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Delete Transaction'),
        content: const Text(
          'Are you sure you want to delete this transaction?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              TransactionDetailCubit.get(context).deleteTransaction(id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ── AppBar ────────────────────────────────────────────────────────────────────
class _TransactionDetailAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: const Color(0xFF4CAF50),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const Expanded(
              child: Text(
                'Transaction Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}

// ── Error View ────────────────────────────────────────────────────────────────
class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded,
                size: 48, color: Color(0xFFD1D5DB)),
            const Gap(16),
            Text(
              message,
              style: const TextStyle(color: Color(0xFF6B7280)),
            ),
            const Gap(16),
            TextButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text(
                'Go to Dashboard',
                style: TextStyle(color: Color(0xFF4CAF50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}