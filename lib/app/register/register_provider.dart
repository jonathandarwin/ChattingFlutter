import 'package:chatting_app/model/user.dart';
import 'package:chatting_app/repository/user_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterProvider extends ChangeNotifier{
  static const int STATUS_SUCCESS = 1;
  static const int STATUS_ERROR = 2;
  static const int STATUS_EXISTS = 3;    
  static const int STATUS_EMPTY = 4;

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

  Future<int> doRegister() async {        
    if(validateInput()){
      DataSnapshot result = await userRepository.getUser(user);
      if(result.value != null){
        Iterable list = result.value.values;
        if(list.length > 0){
          return STATUS_EXISTS;
        }
      }
            
      if(userRepository.insertUser(user)){                
        return STATUS_SUCCESS;
      }
      else{
        return STATUS_ERROR;
      }
    }
    else{
      return STATUS_EMPTY;
    }    
  }

  bool validateInput() {    
    if(user.name == null || user.name.trim() == '' ||
       user.username == null || user.username.trim() == '' || 
       user.password == null || user.password.trim() == ''){
         return false;
    }
    return true;
  }  
}