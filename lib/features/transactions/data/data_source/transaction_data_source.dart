import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';

class TransactionDataSource {
  final SharedPreferences _prefs;
  TransactionDataSource(this._prefs);

  static const String _key = 'transactions';

  // ── Save one transaction ──────────────────────────────────────────────────
  Future<void> save(TransactionModel transaction) async {
    // 1. Get current list as String from prefs
    final String? existingJson = _prefs.getString(_key);

    // 2. Convert String → List
    final List list = existingJson != null ? jsonDecode(existingJson) : [];

    // 3. Add new transaction as Map to the list
    list.add(transaction.toMap());

    // 4. Convert List → String and save
    await _prefs.setString(_key, jsonEncode(list));
  }

  // ── Get all transactions ──────────────────────────────────────────────────
  List<TransactionModel> getAll() {
    // 1. Get String from prefs
    final String? json = _prefs.getString(_key);

    // 2. If nothing saved yet return empty list
    if (json == null) return [];

    // 3. Convert String → List → List<TransactionModel>
    final List list = jsonDecode(json);
    return list
        .map((item) => TransactionModel.fromMap(item))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date)); // newest first
  }

  // ── Delete one transaction ────────────────────────────────────────────────
  Future<void> delete(String id) async {
    // 1. Get all
    final list = getAll();

    // 2. Remove the one we want
    list.removeWhere((t) => t.id == id);

    // 3. Save the updated list back
    await _prefs.setString(
      _key,
      jsonEncode(list.map((t) => t.toMap()).toList()),
    );
  }

  // ── Clear everything ──────────────────────────────────────────────────────
  Future<void> clearAll() async {
    await _prefs.remove(_key);
  }
}