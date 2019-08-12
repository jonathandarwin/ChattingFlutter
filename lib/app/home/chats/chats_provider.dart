import 'package:chatting_app/base/base_provider.dart';
import 'package:chatting_app/model/room.dart';
import 'package:chatting_app/model/user.dart';
import 'package:chatting_app/repository/chat_repository.dart';
import 'package:chatting_app/util/datetime_util.dart';
import 'package:chatting_app/util/session_util.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatsProvider extends BaseProvider{
  static const int SUCCESS = 1;
  static const int NO_DATA = 2;
  static const int ERROR = 3;

  List<Room> _listRoom = List<Room>();
  User _session = User();

  List<Room> get listRoom => _listRoom;
  User get session => _session;

  set listRoom(List<Room> listRoom){
    this._listRoom = listRoom;
    notifyListeners();
  }  

  ChatRepository chatRepository = ChatRepository();

  Future<int> getRoomChat() async {    
    User session = await SessionUtil.loadUserData();
    _session = session;
    // GET ROOM CHAT KEY
    DataSnapshot getRoomChat = await chatRepository.getRoomChatKey(session);
    if(getRoomChat.value != null){
      Iterable iterableRoomChat = getRoomChat.value.values;      
      if(iterableRoomChat.length > 0){
        listRoom.clear();
        for(var item in iterableRoomChat){
          // GET ROOM DETAIL
          DataSnapshot getChatDetail = await chatRepository.getChatDetail(item['id']);
          if(getChatDetail.value != null){            
            Room room = Room.fromJson(getChatDetail.value);
            if(room.chat != null){
              room.chat.sort((a,b) => a.datetime.compareTo(b.datetime));
              listRoom.add(room);
            }             
          }          
        }
        if(listRoom.length > 0)
          return SUCCESS;      
      }
    }
    return NO_DATA;
  }
}