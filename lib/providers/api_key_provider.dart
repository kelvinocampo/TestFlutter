import 'package:flutter/material.dart';
import '../models/api_key_model.dart';
import '../services/api_key_database.dart';

class ApiKeyProvider with ChangeNotifier {
  List<ApiKey> _keys = [];

  List<ApiKey> get keys => _keys;
  bool get canAddMore => _keys.length < 10;

  Future<void> loadKeys() async {
    _keys = await ApiKeyDatabase.getAllKeys();
    notifyListeners();
  }

  Future<void> addKey(ApiKey key) async {
    if (!canAddMore) return;
    await ApiKeyDatabase.insertKey(key);
    await loadKeys();
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
