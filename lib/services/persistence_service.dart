import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceService {
  static const String _formDataKey = 'form_draft_data';
  static const String _currentStepKey = 'form_current_step';

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

  Future<bool> saveCurrentStep(int step) async {
    try {
      return await _prefs.setInt(_currentStepKey, step);
    } catch (e) {
      print('Error saving current step: $e');
      return false;
    }
  }

  Future<int> loadCurrentStep() async {
    try {
      return _prefs.getInt(_currentStepKey) ?? 0;
    } catch (e) {
      print('Error loading current step: $e');
      return 0;
    }
  }

  Future<bool> clearFormData() async {
    try {
      await _prefs.remove(_formDataKey);
      await _prefs.remove(_currentStepKey);
      return true;
    } catch (e) {
      print('Error clearing form data: $e');
      return false;
    }
  }

  bool hasSavedDraft() {
    return _prefs.containsKey(_formDataKey);
  }

  DateTime? getLastSavedTime() {
    // TODO: Implement timestamp tracking
    return null;
  }
}
