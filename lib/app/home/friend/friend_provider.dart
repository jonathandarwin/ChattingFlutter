import 'package:chatting_app/base/base_provider.dart';
import 'package:chatting_app/model/room.dart';
import 'package:chatting_app/model/user.dart';
import 'package:chatting_app/repository/chat_repository.dart';
import 'package:chatting_app/repository/friend_repository.dart';
import 'package:chatting_app/repository/user_repository.dart';
import 'package:chatting_app/util/session_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tuple/tuple.dart';


class FriendsProvider extends BaseProvider{
  static const int SHOW_DATA = 1;
  static const int NO_DATA = 2;
  static const int LOADING = 3;
  static const int ERROR = 4;  

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

  Future<int> getFriends() async {    
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
        _listFriend = listTemp;
        return SHOW_DATA;
      }
    }
    return NO_DATA;      
  }

  Future<bool> deleteFriend(User user) async {
    User session = await SessionUtil.loadUserData();
    return friendRepository.deleteFriends(session, user);
  }

  Future<Tuple2<Room, User>> getRoomChat(User user) async {            
    User session = await SessionUtil.loadUserData();        
    // CHECK WHETHER THE ROOM CHAT IS EXISTS OR NOT
    DataSnapshot getRoomChat = await chatRepository.getRoomChat(session);
    if(getRoomChat.value != null){            
      // SEARCH THE EXISTING ROOM AND RETURN IT
      Iterable iterableRoom = getRoomChat.value.values;
      for (var item in iterableRoom){
        String id = item['id'];
        if(id.contains(user.username)){    
          // GET ROOM CHAT 
          DataSnapshot getChat = await chatRepository.getChat(id);
          if(getChat != null){
            Room room = Room.fromJson(getChat.value);
            Tuple2<Room, User> result = new Tuple2<Room, User>(room, session.username == room.user1.username ? room.user2 : room.user1);
            return result;
          }          
        }
      }      
    }

    // INSERT THE KEY OF THE ROOM CHAT, AND RETURN IT TO CLIENT      
    Room room = Room.setData(
      session.username + user.username,
      session,
      user,
      null
    );
    chatRepository.insertRoomChat(room);
    Tuple2<Room, User> result = new Tuple2<Room, User>(room, user);
    return result;
  }
}