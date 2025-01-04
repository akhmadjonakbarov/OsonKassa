import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
// Read value
  Future<String?> read(String key) async {
    final SharedPreferences prefs = await _prefs;
    String? value = prefs.getString(key);
    return value;
  }

// Read all values
// Map<String, String> allValues = await storage.readAll();

// Delete value
  Future<void> delete(String key) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(key);
  }

// Delete all
// await storage.deleteAll();

// Write value
  Future write(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(key, value);
  }
}
