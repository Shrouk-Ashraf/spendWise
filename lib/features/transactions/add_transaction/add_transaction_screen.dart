import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/features/transactions/add_transaction/widgets/amount_field.dart';
import 'package:spendwise/features/transactions/add_transaction/widgets/category_dropdown.dart';
import 'package:spendwise/features/transactions/add_transaction/widgets/date_picker_field.dart';
import 'package:spendwise/features/transactions/add_transaction/widgets/notes_field.dart';
import 'package:spendwise/features/transactions/add_transaction/widgets/transaction_action_buttons.dart';
import 'package:spendwise/features/transactions/add_transaction/widgets/transaction_type_toggle.dart';
import 'package:spendwise/features/transactions/data/models/transaction_model.dart';

import '../../../config/di/di.dart';
import '../../../core/theme/app_colors.dart';
import 'cubit/add_transaction_cubit.dart';
import 'cubit/add_transaction_state.dart';

const List<String> categories = [
  'Food & Dining',
  'Shopping',
  'Transport',
  'Bills & Utilities',
  'Entertainment',
  'Healthcare',
  'Education',
  'Salary',
  'Freelance',
  'Investment',
  'Other',
];

class AddTransactionScreen extends StatefulWidget {
  final String? initialType;

  const AddTransactionScreen({super.key, this.initialType});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  late String _type;
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedCategory = categories.first;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _type = widget.initialType == 'income' ? 'income' : 'expense';
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // TODO: save transaction via BLoC
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TransactionCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
        body: BlocConsumer<TransactionCubit, TransactionState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            final cubit =TransactionCubit.get(context);
            return CustomScrollView(
              slivers: [
                _AddTransactionAppBar(type: _type),
                SliverToBoxAdapter(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          TransactionTypeToggle(
                            selected: _type,
                            onChanged: (v) => setState(() => _type = v),
                          ),
                          const Gap(24),
                          AmountField(controller: _amountController),
                          const Gap(16),
                          CategoryDropdown(
                            selected: _selectedCategory,
                            onChanged: (v) =>
                                setState(() => _selectedCategory = v),
                          ),
                          const Gap(16),
                          DatePickerField(
                            selectedDate: _selectedDate,
                            onChanged: (v) => setState(() => _selectedDate = v),
                          ),
                          const Gap(16),
                          NotesField(controller: _notesController),
                          const Gap(24),
                          TransactionActionButtons(
                            onCancel: () => context.go('/dashboard'),
                            onSave: (){
                              if (_formKey.currentState!.validate()) {
                                cubit.addTransaction(TransactionModel(
                                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                                  type: _type,
                                  category: _selectedCategory,
                                  amount: double.parse(_amountController.text),
                                  date: _selectedDate,
                                  notes: _notesController.text,
                                ));
                              }
                            },
                          ),
                          const Gap(32),
                        ],
                      ),
                    ),
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

// ── Private AppBar ────────────────────────────────────────────────────────────
class _AddTransactionAppBar extends StatelessWidget {
  const _AddTransactionAppBar({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 1,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              onPressed: () => context.go('/dashboard'),
              icon: const Icon(Icons.arrow_back, color: Color(0xFF374151)),
            ),
            Text(
              type == 'income' ? 'Add Income' : 'Add Expense',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }
}