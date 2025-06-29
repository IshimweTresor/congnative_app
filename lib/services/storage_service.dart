import 'dart:convert';

class StorageService {
  static const String _firstLaunchKey = 'first_launch_complete';
  static const String _userProfileKey = 'user_profile';
  static const String _medicationsKey = 'medications';
  static const String _routineStepsKey = 'routine_steps';
  static const String _remindersKey = 'reminders';
  static const String _settingsKey = 'app_settings';

  // In-memory storage for demo purposes
  // In a real app, you would use SharedPreferences or another persistence solution
  static final Map<String, dynamic> _storage = {};

  // Initialize (for demo purposes, this is empty)
  static Future<void> init() async {
    // Initialize any required setup
  }

  // First launch management
  static Future<void> setFirstLaunchComplete() async {
    _storage[_firstLaunchKey] = true;
  }

  static bool isFirstLaunch() {
    return !(_storage[_firstLaunchKey] ?? false);
  }

  // Generic methods for storing different types of data
  static Future<bool> setString(String key, String value) async {
    _storage[key] = value;
    return true;
  }

  static String? getString(String key) {
    return _storage[key] as String?;
  }

  static Future<bool> setBool(String key, bool value) async {
    _storage[key] = value;
    return true;
  }

  static bool? getBool(String key) {
    return _storage[key] as bool?;
  }

  static Future<bool> setInt(String key, int value) async {
    _storage[key] = value;
    return true;
  }

  static int? getInt(String key) {
    return _storage[key] as int?;
  }

  static Future<bool> setDouble(String key, double value) async {
    _storage[key] = value;
    return true;
  }

  static double? getDouble(String key) {
    return _storage[key] as double?;
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    _storage[key] = value;
    return true;
  }

  static List<String>? getStringList(String key) {
    return (_storage[key] as List?)?.cast<String>();
  }

  // JSON storage methods
  static Future<bool> setJson(String key, Map<String, dynamic> value) async {
    _storage[key] = jsonEncode(value);
    return true;
  }

  static Map<String, dynamic>? getJson(String key) {
    final jsonString = _storage[key] as String?;
    if (jsonString != null) {
      try {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        // Error decoding JSON for key $key: $e
        return null;
      }
    }
    return null;
  }

  static Future<bool> setJsonList(
    String key,
    List<Map<String, dynamic>> value,
  ) async {
    _storage[key] = jsonEncode(value);
    return true;
  }

  static List<Map<String, dynamic>>? getJsonList(String key) {
    final jsonString = _storage[key] as String?;
    if (jsonString != null) {
      try {
        final decoded = jsonDecode(jsonString) as List;
        return decoded.cast<Map<String, dynamic>>();
      } catch (e) {
        // Error decoding JSON list for key $key: $e
        return null;
      }
    }
    return null;
  }

  // Specific app data methods
  static Future<bool> saveUserProfile(Map<String, dynamic> profile) async {
    return await setJson(_userProfileKey, profile);
  }

  static Map<String, dynamic>? getUserProfile() {
    return getJson(_userProfileKey);
  }

  static Future<bool> saveMedications(
    List<Map<String, dynamic>> medications,
  ) async {
    return await setJsonList(_medicationsKey, medications);
  }

  static List<Map<String, dynamic>>? getMedications() {
    return getJsonList(_medicationsKey);
  }

  static Future<bool> saveRoutineSteps(List<Map<String, dynamic>> steps) async {
    return await setJsonList(_routineStepsKey, steps);
  }

  static List<Map<String, dynamic>>? getRoutineSteps() {
    return getJsonList(_routineStepsKey);
  }

  static Future<bool> saveReminders(
    List<Map<String, dynamic>> reminders,
  ) async {
    return await setJsonList(_remindersKey, reminders);
  }

  static List<Map<String, dynamic>>? getReminders() {
    return getJsonList(_remindersKey);
  }

  static Future<bool> saveAppSettings(Map<String, dynamic> settings) async {
    return await setJson(_settingsKey, settings);
  }

  static Map<String, dynamic>? getAppSettings() {
    return getJson(_settingsKey);
  }

  // Clear methods
  static Future<bool> remove(String key) async {
    _storage.remove(key);
    return true;
  }

  static Future<bool> clear() async {
    _storage.clear();
    return true;
  }

  static Future<bool> clearAppData() async {
    // Clear all app-specific data but keep system preferences
    final keys = [
      _userProfileKey,
      _medicationsKey,
      _routineStepsKey,
      _remindersKey,
      _settingsKey,
    ];

    for (String key in keys) {
      _storage.remove(key);
    }
    return true;
  }

  // Check if key exists
  static bool containsKey(String key) {
    return _storage.containsKey(key);
  }

  // Get all keys
  static Set<String> getAllKeys() {
    return _storage.keys.toSet();
  }
}
