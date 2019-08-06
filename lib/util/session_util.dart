import 'package:chatting_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionUtil{
  static Future<void> saveUserData(User user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('username', user.username);
    preferences.setString('password', user.password);
    preferences.setString('name', user.name);
  }

  static Future<User> loadUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    User user = User.setData(
      preferences.getString('name'), 
      preferences.getString('username'), 
      preferences.getString('password'));
    return user;
  }

  static Future<void> deleteUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}