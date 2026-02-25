import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../features/transactions/data/models/transaction_model.dart';

class DashboardDataSource {
  final SharedPreferences _prefs;
  DashboardDataSource(this._prefs);

  static const String _key = 'transactions';

  /// Returns up to [count] most recent transactions stored in SharedPreferences.
  List<TransactionModel> getRecent({int count = 10}) {
    final String? json = _prefs.getString(_key);
    if (json == null) return [];

    final List decoded = jsonDecode(json);

    final transactions = decoded
        .map((item) {
          try {
            return TransactionModel.fromMap(Map<String, dynamic>.from(item));
          } catch (_) {
            return null;
          }
        })
        .whereType<TransactionModel>()
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return transactions.take(count).toList();
  }
}
