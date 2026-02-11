import 'package:hive/hive.dart';
import 'package:spendwise/core/networking/error_handler.dart';


abstract class LocalStorageService {
  Future<Box<T>> openBox<T>(String boxName);
  Future<void> saveData<T>(String boxName, String key, T value);
  Future<T?> getData<T>(String boxName, String key);
  Future<void> deleteData(String boxName, String key);
  Future<void> clearBox(String boxName);
  Future<bool> containsKey(String boxName, String key);
  Future<List<T>> getAllValues<T>(String boxName);
  Future<void> closeBox(String boxName);
}

class LocalStorageServiceImpl implements LocalStorageService {
  @override
  Future<Box<T>> openBox<T>(String boxName) async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        return Hive.box<T>(boxName);
      }
      return await Hive.openBox<T>(boxName);
    } catch (e) {
      throw Exception(ErrorHandler.handleHiveError(e));
    }
  }

  @override
  Future<void> saveData<T>(String boxName, String key, T value) async {
    try {
      final box = await openBox<T>(boxName);
      await box.put(key, value);
    } catch (e) {
      throw Exception(ErrorHandler.handleHiveError(e));
    }
  }

  @override
  Future<T?> getData<T>(String boxName, String key) async {
    try {
      final box = await openBox<T>(boxName);
      return box.get(key);
    } catch (e) {
      throw Exception(ErrorHandler.handleHiveError(e));
    }
  }

  @override
  Future<void> deleteData(String boxName, String key) async {
    try {
      final box = await openBox(boxName);
      await box.delete(key);
    } catch (e) {
      throw Exception(ErrorHandler.handleHiveError(e));
    }
  }

  @override
  Future<void> clearBox(String boxName) async {
    try {
      final box = await openBox(boxName);
      await box.clear();
    } catch (e) {
      throw Exception(ErrorHandler.handleHiveError(e));
    }
  }

  @override
  Future<bool> containsKey(String boxName, String key) async {
    try {
      final box = await openBox(boxName);
      return box.containsKey(key);
    } catch (e) {
      throw Exception(ErrorHandler.handleHiveError(e));
    }
  }

  @override
  Future<List<T>> getAllValues<T>(String boxName) async {
    try {
      final box = await openBox<T>(boxName);
      return box.values.toList();
    } catch (e) {
      throw Exception(ErrorHandler.handleHiveError(e));
    }
  }

  @override
  Future<void> closeBox(String boxName) async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).close();
      }
    } catch (e) {
      throw Exception(ErrorHandler.handleHiveError(e));
    }
  }
}
