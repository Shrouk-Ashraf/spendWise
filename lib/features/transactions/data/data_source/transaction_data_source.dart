import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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

    debugPrint("list added is $list");

    // 4. Convert List → String and save
    await _prefs.setString(_key, jsonEncode(list));

    debugPrint("saved json is ${_prefs.getString(_key)}");
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


  Future<TransactionModel> getTransactionById(String id) async {
    final transactions = getAll();
    return transactions.firstWhere((t) => t.id == id,
        orElse: () => throw Exception('Transaction not found'));

  }

  /// Fetch currency symbols from exchangeratesapi.io
  ///
  /// `accessKey` is required by the API. Optional `baseUrl` defaults to
  /// https://api.exchangeratesapi.io/v1
  Future<Map<String, String>> fetchCurrencySymbols({
    required String accessKey,
    String baseUrl = 'https://api.exchangeratesapi.io/v1',
  }) async {
    final uri = Uri.parse('$baseUrl/symbols?access_key=$accessKey');
    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw Exception('Failed to fetch symbols: ${resp.statusCode}');
    }

    final Map<String, dynamic> body = jsonDecode(resp.body);
    if (body['success'] != true) {
      // API may return error details; include them when present
      final error = body['error'] != null ? body['error'].toString() : body.toString();
      throw Exception('API error: $error');
    }

    final Map<String, dynamic> symbols = body['symbols'] ?? {};
    return symbols.map((k, v) => MapEntry(k, v.toString()));
  }
}