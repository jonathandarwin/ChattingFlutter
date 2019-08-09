import 'package:chatting_app/model/room.dart';
import 'package:chatting_app/model/user.dart';
import 'package:chatting_app/repository/chat_repository.dart';
import 'package:chatting_app/util/session_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

class ChatsProvider extends ChangeNotifier{
  static const int SUCCESS = 1;
  static const int NO_DATA = 2;
  static const int ERROR = 3;

  List<Room> listChat = List<Room>();

  ChatRepository chatRepository = ChatRepository();

  getRoomChat() async {
    User session = await SessionUtil.loadUserData();
    // GET ROOM CHAT KEY
    DataSnapshot getRoomChat = await chatRepository.getRoomChat(session);
    if(getRoomChat.value != null){
      Iterable iterableRoomChat = getRoomChat.value.values;
      if(iterableRoomChat.length > 0){
        for(var item in iterableRoomChat){
          _
        }
      }
    }
    return NO_DATA;
  }
}