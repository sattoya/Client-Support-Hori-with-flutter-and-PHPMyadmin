import 'package:shared_preferences/shared_preferences.dart';

class User{

  static Future<bool?> getsignin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("sign-in");
  }

  static Future setsignin(bool signin) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("sign-in", signin);
  }
}