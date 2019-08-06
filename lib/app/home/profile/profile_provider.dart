import 'package:chatting_app/util/session_util.dart';
import 'package:flutter/foundation.dart';

class ProfileProvider extends ChangeNotifier{
  void logout() async {
    await SessionUtil.deleteUserData();
  }
}