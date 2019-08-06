import 'package:chatting_app/model/user.dart';
import 'package:chatting_app/repository/friend_repository.dart';
import 'package:chatting_app/repository/user_repository.dart';
import 'package:chatting_app/util/session_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class AddFriendProvider extends ChangeNotifier {
  static const int ADD_FRIEND_SUCCESS = 1;
  static const int ADD_FRIEND_ERROR = 2;
  
  static const int SEARCH_FOUND = 3;
  static const int SEARCH_NOT_FOUND = 4;
  static const int SEARCH_ALREADY_FRIEND = 5;

  UserRepository userRepository = UserRepository();
  FriendRepository friendRepository = FriendRepository();  

  String _search = '';
  User _user;
  bool _buttonVisibility = false;
  String _message = '';
  bool _loading = false;

  AddFriendProvider(){
    user = User();
    user.name = '';
    user.username = '';
  }  

  get search => _search;
  get user => _user;
  get buttonVisibility => _buttonVisibility;
  get message => _message;
  get loading => _loading;

  set search(String search){
    this._search = search;
    notifyListeners();
  }
  set user(User user){
    this._user = user;
    notifyListeners();
  }
  set buttonVisibility(bool buttonVisibility){
    this._buttonVisibility = buttonVisibility;
    notifyListeners();
  }
  set message(String message){
    this._message = message;
    notifyListeners();
  }
  set loading(bool loading){
    this._loading = loading;
    notifyListeners();
  }

  Future<int> searchUser() async {
    User session = await SessionUtil.loadUserData();  
    User param = User();
    param.username = search;

    // SEARCH EXISTING FRIENDS
    DataSnapshot searchInFriend = await friendRepository.getFriendById(session.username, param.username);
    if(searchInFriend.value != null){
      user = User.fromJson(searchInFriend.value);
      buttonVisibility = false;
      message = 'You already friend with ${user.name}';
      return SEARCH_ALREADY_FRIEND;      
    }

    // SEARCH FRIENDS
    DataSnapshot result = await userRepository.getUser(param);
    if(result.value != null){
      Iterable list = result.value.values;
      if(list.length > 0){
        for(var item in list){
          user = User.fromJson(item);
          if(user.username != session.username){
            buttonVisibility = true;
            message = '';
            return SEARCH_FOUND;          
          }          
          break;
        }
      }
    }
    user.name = '';
    user.username = '';
    user.password = '';
    buttonVisibility = false;
    message = 'No User Found';
    return SEARCH_NOT_FOUND;
  }

  Future<int> addFriend() async {
    User session = await SessionUtil.loadUserData();        
    if(friendRepository.addFriends(session, user)){
      buttonVisibility = false;
      return ADD_FRIEND_SUCCESS;
    }
    return ADD_FRIEND_ERROR;    
  }
}