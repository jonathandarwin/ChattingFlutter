import 'package:chatting_app/model/user.dart';
import 'package:chatting_app/repository/friend_repository.dart';
import 'package:chatting_app/util/session_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class FriendsProvider extends ChangeNotifier{
  static const int LOAD_FRIEND_SUCCESS = 1;
  static const int LOAD_FRIEND_NO_DATA = 2;
  static const int LOAD_FRIEND_ERROR = 3;

  FriendRepository friendRepository = FriendRepository();
  List<User> _listFriend = List<User>();
  User _selected = User();

  get listFriend => _listFriend;
  get selected => _selected;

  set listFriend(List<User> listFriend){
    this._listFriend = listFriend;
    notifyListeners();    
  }
  set selected(User selected){
    this._selected = selected;
    notifyListeners();
  }

  Future<int> getFriends() async {
    User session = await SessionUtil.loadUserData();        
    DataSnapshot result = await friendRepository.getFriend(session.username);        
    if(result.value != null) {
      Iterable list = result.value.values;      
      if(list.length > 0){
        List<User> listTemp = List<User>();        
        for(var item in list){
          listTemp.add(User.fromJson(item));          
        }
        listFriend = listTemp;        
        return LOAD_FRIEND_SUCCESS;
      }      
      return LOAD_FRIEND_NO_DATA;
    }    
    return LOAD_FRIEND_NO_DATA;
  }

  Future<bool> deleteFriend(User user) async {
    User session = await SessionUtil.loadUserData();
    return friendRepository.deleteFriends(session, user);
  }
}