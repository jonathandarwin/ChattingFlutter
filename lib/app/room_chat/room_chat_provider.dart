import 'package:chatting_app/base/base_provider.dart';
import 'package:chatting_app/model/chat.dart';
import 'package:chatting_app/model/room.dart';
import 'package:chatting_app/model/user.dart';
import 'package:chatting_app/repository/chat_repository.dart';
import 'package:chatting_app/util/session_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class RoomChatProvider extends BaseProvider {  
  ChatRepository chatRepository = ChatRepository();

  String _message;  
  List<Chat> _listChat = List<Chat>();
  bool _isRefresh = true;

  // CONTROLLER
  ScrollController _scrollController = ScrollController();
  TextEditingController _textController = TextEditingController();  

  String get message => _message;
  List<Chat> get listChat => _listChat;
  bool get isRefresh => _isRefresh;  
  ScrollController get scrollController => _scrollController;
  TextEditingController get textController => _textController;
  

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

  getListChat(String id){        
    if(isRefresh){
      chatRepository.getListChat(id).listen((result){
        DataSnapshot snapshot = result.snapshot;        
        Chat chat = Chat.fromJson(snapshot.value);        
        listChat.add(chat);
        refresh();                

        // SET TO THE BOTTOM
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut
        );
        isRefresh = false;
      });    
    }
  }
}