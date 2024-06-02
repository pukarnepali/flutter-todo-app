import 'package:shared_preferences/shared_preferences.dart';

class todoProvider {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future saveTodo(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(key, value);
  }

  Future<String> getTodo(String key) async {
    final SharedPreferences prefs = await _prefs;
    var response = prefs.getString(key) ?? "";
    return response;
  }
}
