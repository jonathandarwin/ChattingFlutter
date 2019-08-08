import 'dart:async';

import 'package:chatting_app/base/base_provider.dart';
import 'package:chatting_app/model/chat.dart';
import 'package:chatting_app/model/room.dart';
import 'package:chatting_app/model/user.dart';
import 'package:chatting_app/repository/chat_repository.dart';
import 'package:chatting_app/util/session_util.dart';
import 'package:firebase_database/firebase_database.dart';

class RoomChatProvider extends BaseProvider {
  ChatRepository chatRepository = ChatRepository();

  String _message;  
  List<Chat> _listChat = List<Chat>();
  bool _isRefresh = true;

  String get message => _message;
  List<Chat> get listChat => _listChat;
  bool get isRefresh => _isRefresh;

  set message(String message){
    this._message = message;    
  }
  set listChat(List<Chat> listChat){
    this._listChat = listChat;
    notifyListeners();
  }
  set isRefresh(bool isRefresh){
    this._isRefresh = isRefresh;
  }

  insertChat(Room room, User user) async {
    User session = await SessionUtil.loadUserData();
    Chat chat = Chat.setData(session.username, message);
    chatRepository.insertChat(room.id, chat);    
  }

  // Future<List<Chat>> getListChat(String id) async {    
  //   DataSnapshot getListChat = await chatRepository.getListChat(id);
  //   if(getListChat.value != null){
  //     Iterable iterableChat = getListChat.value.values;
  //     List<Chat> listChat = List<Chat>();
  //     if(iterableChat.length > 0){
  //       for(var item in iterableChat){
  //         Chat chat = Chat.fromJson(item); 
  //         listChat.add(chat);
  //       }
  //       _listChat = listChat;
  //       return listChat;
  //     }
  //   }    
  //   return List<Chat>();
  // }  

  getListChat(String id){        
    if(isRefresh){
      chatRepository.getListChat(id).listen((result){
        DataSnapshot snapshot = result.snapshot;
        List<Chat> listTemp = List<Chat>();
        Chat chat = Chat.fromJson(snapshot.value);
        listTemp = listChat;
        listTemp.add(chat);
        listChat = listTemp;
        
        isRefresh = false;
      });    
    }
  }
}