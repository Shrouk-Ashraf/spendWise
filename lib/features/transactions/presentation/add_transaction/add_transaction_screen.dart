import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/features/transactions/presentation/add_transaction/widgets/amount_field.dart';
import 'package:spendwise/features/transactions/presentation/add_transaction/widgets/category_dropdown.dart';
import 'package:spendwise/features/transactions/presentation/add_transaction/widgets/date_picker_field.dart';
import 'package:spendwise/features/transactions/presentation/add_transaction/widgets/notes_field.dart';
import 'package:spendwise/features/transactions/presentation/add_transaction/widgets/transaction_action_buttons.dart';
import 'package:spendwise/features/transactions/data/models/transaction_model.dart';
import 'package:spendwise/features/transactions/presentation/add_transaction/widgets/transaction_type_toggle.dart';

import '../../../../config/di/di.dart';
import '../../../../core/theme/app_colors.dart';
import 'cubit/add_transaction_cubit.dart';
import 'cubit/add_transaction_state.dart';

const Map<String,dynamic> categories = {
  'Food & Dining': Icons.restaurant,
  'Shopping': Icons.shopping_bag,
  'Transport':Icons.emoji_transportation,
  'Bills & Utilities': Icons.receipt_long,
  'Entertainment': Icons.movie,
  'Healthcare': Icons.local_hospital,
  'Education': Icons.school,
  'Salary': Icons.attach_money,
  'Freelance': Icons.work,
  'Investment': Icons.trending_up,
  'Other': Icons.category,
};

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
  String _selectedCategory = categories.keys.first;
  IconData _selectedIcon = categories.values.first;
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => sl<AddTransactionCubit>()..loadCurrencySymbols(accessKey: '0f176a72a2ee0f175903e1356d67c346'),
  child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back, color: Color(0xFF374151)),
              ),
              Text(
                _type == 'income' ? 'Add Income' : 'Add Expense',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.lightBackgroundColor,
      body: BlocConsumer<AddTransactionCubit, AddTransactionState>(
        listener: (context, state) {
          if(state.status == TransactionStatus.loading){
            EasyLoading.show();
          }else if(state.status == TransactionStatus.success){
            EasyLoading.dismiss();
            context.pop(true);
          }else if(state.status == TransactionStatus.error){
            EasyLoading.dismiss();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
            );
          }else {
            EasyLoading.dismiss();
          }
        },
        builder: (context, state) {
          final cubit =AddTransactionCubit.get(context);
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
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
                          setState(()  {
                            _selectedCategory = v;
                          _selectedIcon =categories[v];
                          }),
                    ),
                    const Gap(16),
                    DatePickerField(
                      selectedDate: _selectedDate,
                      onChanged: (v) => setState(() => _selectedDate = v),
                    ),
                    const Gap(16),
                    NotesField(controller: _notesController),
                    const Gap(16),

                    // Currency selector: show loading, error or the dropdown
                    state.currencyStatus == CurrencyStatus.loading
                        ? const Center(child: CircularProgressIndicator())
                        : state.currencyStatus == CurrencyStatus.error
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(state.currencyErrorMessage ?? 'Failed to load currencies'),
                                  ),
                                  TextButton(
                                    onPressed: () => cubit.loadCurrencySymbols(accessKey: '0f176a72a2ee0f175903e1356d67c346'),
                                    child: const Text('Retry'),
                                  ),
                                ],
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  initialValue: state.selectedCurrency,
                                  decoration: const InputDecoration(
                                    labelText: 'Currency',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: state.currencySymbols.keys
                                      .map(
                                        (code) => DropdownMenuItem(
                                          value: code,
                                          child: Text(
                                            '$code — ${state.currencySymbols[code]}',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (v) {
                                    if (v != null) cubit.setSelectedCurrency(v);
                                  },
                                ),
                              ),

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
                            categoryIcon: _selectedIcon,
                          ));
                        }
                      },
                    ),
                    const Gap(32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
);
  }
}
