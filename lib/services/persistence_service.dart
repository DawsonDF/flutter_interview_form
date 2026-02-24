import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceService {
  static const String _formDataKey = 'form_data';

  late SharedPreferences _prefs;
  bool _initialized = false;

  /// Initialize the persistence service
  Future<void> initialize() async {
    if (_initialized) return;
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  Future<bool> saveFormData(Map<String, dynamic> data) async {
    try {
      final jsonString = jsonEncode(data);
      return await _prefs.setString(_formDataKey, jsonString);
    } catch (e) {
      print('Error saving form data: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> loadFormData() async {
    try {
      final jsonString = _prefs.getString(_formDataKey);
      if (jsonString == null) return null;

      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      print('Error loading form data: $e');
      return null;
    }
  }

  Future<bool> clearFormData() async {
    try {
      await _prefs.remove(_formDataKey);
      return true;
    } catch (e) {
      print('Error clearing form data: $e');
      return false;
    }
  }
}
