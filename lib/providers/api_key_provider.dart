import 'package:flutter/material.dart';
import '../models/api_key_model.dart';
import '../services/api_key_database.dart';
import '../l10n/app_localizations.dart';

class ApiKeyProvider with ChangeNotifier {
  List<ApiKey> _keys = [];

  List<ApiKey> get keys => _keys;
  bool get canAddMore => _keys.length < 10;

  Future<void> loadKeys() async {
    _keys = await ApiKeyDatabase.getAllKeys();
    notifyListeners();
  }

  Future<void> addKey(BuildContext context, String name, String key) async {
    final localizations = AppLocalizations.of(context)!;

    if (_keys.length >= 10) {
      throw Exception(localizations.limit_apikeys);
    }

    final existsByName = _keys.any((k) => k.name == name);
    if (existsByName) {
      throw Exception(localizations.name_exists);
    }

    final existsByKey = _keys.any((k) => k.key == key);
    if (existsByKey) {
      throw Exception(localizations.key_exists);
    }

    final newKey = ApiKey(name: name, key: key);
    final id = await ApiKeyDatabase.insertKey(newKey);
    _keys.add(newKey.copyWith(id: id));
    notifyListeners();
  }

  Future<void> editKey(ApiKey updated) async {
    await ApiKeyDatabase.updateKey(updated);
    await loadKeys();
  }

  Future<void> deleteKey(int id) async {
    await ApiKeyDatabase.deleteKey(id);
    await loadKeys();
  }

  Future<void> activateKey(int id) async {
    await ApiKeyDatabase.activateKey(id);
    await loadKeys();
  }
}
