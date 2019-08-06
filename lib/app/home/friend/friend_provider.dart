import 'package:chatting_app/model/room.dart';
import 'package:chatting_app/model/user.dart';
import 'package:chatting_app/repository/chat_repository.dart';
import 'package:chatting_app/repository/friend_repository.dart';
import 'package:chatting_app/repository/user_repository.dart';
import 'package:chatting_app/util/session_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsProvider extends ChangeNotifier{
  static const int LOAD_FRIEND_SUCCESS = 1;
  static const int LOAD_FRIEND_NO_DATA = 2;
  static const int LOAD_FRIEND_ERROR = 3;
  static const int LOADING = 4;

  FriendRepository friendRepository = FriendRepository();
  UserRepository userRepository = UserRepository();
  ChatRepository chatRepository = ChatRepository();

  List<User> _listFriend = List<User>();
  User _selected = User();
  int _state;

  get listFriend => _listFriend;
  get selected => _selected;
  get state => _state;

  set listFriend(List<User> listFriend){
    this._listFriend = listFriend;
    notifyListeners();    
  }
  set selected(User selected){
    this._selected = selected;
    notifyListeners();
  }
  set state(int state){
    this._state = state;
    notifyListeners();
  }

  getFriends() async {
    _state = LOADING;
    User session = await SessionUtil.loadUserData();                
    DataSnapshot result = await friendRepository.getFriend(session.username);        
    if(result.value != null) {
      Iterable iterableId = result.value.values;                  
      if(iterableId.length > 0){        
        List<User> listTemp = List<User>();
        for(var item in iterableId){          
          DataSnapshot result2 = await userRepository.getUserbyId(item['id'].toString());
          if(result2.value != null){
            listTemp.add(User.fromJson(result2.value));            
          }          
        }        
        listFriend = listTemp;
        _state = LOAD_FRIEND_SUCCESS;
        return;    
      }      
    }
    state = LOAD_FRIEND_NO_DATA;            
    return;    
  }

  Future<bool> deleteFriend(User user) async {
    User session = await SessionUtil.loadUserData();
    return friendRepository.deleteFriends(session, user);
  }

  Future<String> getRoomChat(User user) async {    
    User session = await SessionUtil.loadUserData();        
    // CHECK WHETHER THE ROOM CHAT IS EXISTS OR NOT
    DataSnapshot getRoomChat = await chatRepository.getRoomChat(session);
    if(getRoomChat.value != null){            
      // SEARCH THE EXISTING ROOM AND RETURN IT
      Iterable iterableRoom = getRoomChat.value.values;
      for (var item in iterableRoom){        
        String id = item['id'];
        if(id.contains(user.username)){
          return id;
        }
      }      
    }
    // INSERT THE KEY OF THE ROOM CHAT, AND RETURN IT TO CLIENT      
    Room room = Room.setData(
      session,
      user,
      null
    );
    return chatRepository.insertChat(room);      
  }
}