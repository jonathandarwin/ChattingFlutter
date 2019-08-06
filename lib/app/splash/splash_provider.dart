import 'package:chatting_app/model/user.dart';
import 'package:chatting_app/util/session_util.dart';
import 'package:flutter/foundation.dart';

class SplashProvider extends ChangeNotifier{
  static const int GOTO_LOGIN = 1;
  static const int GOTO_HOME = 2;

  Future<int> checkSession() async {
    User user = await SessionUtil.loadUserData();
    if(user.username != null && user.username.trim().length != 0){
      return GOTO_HOME;
    }
    return GOTO_LOGIN;
  }
}