import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String LAST_CITY_KEY = 'last_city';

  // Lưu tên thành phố cuối cùng
  Future<void> saveLastCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LAST_CITY_KEY, city);
  }

  // Lấy tên thành phố cuối cùng
  Future<String?> getLastCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(LAST_CITY_KEY);
  }
}
