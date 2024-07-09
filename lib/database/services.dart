import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static String valueSharedPreferences = '';

  static Future<bool> saveUserData(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setInt(valueSharedPreferences, value);
  }

  static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(valueSharedPreferences);
  }
}
