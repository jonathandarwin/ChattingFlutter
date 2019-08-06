import 'package:chatting_app/model/user.dart';
import 'package:chatting_app/repository/user_repository.dart';
import 'package:chatting_app/util/session_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class LoginProvider extends ChangeNotifier{
  static const int LOGIN_SUCCESS = 1;
  static const int LOGIN_INCORRECT = 2;
  static const int LOGIN_ERROR = 3;

  UserRepository userRepository = UserRepository();
  User _user = User();
  bool _isLoading = false;  

  get user => _user;
  get isLoading => _isLoading;  

  set user(User user){
    this._user.name = user.name;
    this._user.username = user.username;
    this._user.password = user.password;
    notifyListeners();
  }
  set isLoading(bool isLoading){
    this._isLoading = isLoading;
    notifyListeners();
  }

  Future<int> doLogin() async {        
    User data;    
    DataSnapshot result = await userRepository.getUser(user);
    if(result.value != null){
      Iterable list = result.value.values;
      if(list.length > 0){
        for(var item in list){
          data = User.fromJson(item);
          if(data.password == user.password){
            user.name = data.name;
            SessionUtil.saveUserData(user);
            return LOGIN_SUCCESS;
          }                   
        }        
      }       
    }
    return LOGIN_INCORRECT;
  }

  bool validateInput(){
    if(user.username == null || user.username.trim() == "" || 
       user.password == null || user.password.trim() == ""){
         return false;
    }
    return true;
  }
}