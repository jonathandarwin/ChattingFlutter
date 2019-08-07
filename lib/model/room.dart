import 'dart:convert';

import 'package:chatting_app/model/chat.dart';
import 'package:chatting_app/model/user.dart';

class Room{
  String _id;
  User _user1;
  User _user2;
  List<Chat> _chat;

  Room();

  Room.setData(
    this._id,
    this._user1,
    this._user2,
    this._chat
  );

  Room.fromJson(Map<dynamic, dynamic> data){
    this._id = data['id'].toString();
    this._user1 = User.fromJson(data['user1']);
    this._user2 = User.fromJson(data['user2']);
    Iterable iterableChat = data['chat'];
    if(iterableChat != null){
      this._chat = iterableChat.map((model) => Chat.fromJson(model)).toList();
    }
  }

  String get id => _id;
  User get user1 => _user1;
  User get user2 => _user2;
  List<Chat> get chat => _chat;  

  set id(String id) => this._id = id;
  set user1(User user1) => this._user1 = user1;
  set user2(User user2) => this._user2 = user2;
  set chat(List<Chat> chat) => this._chat = chat;

  Map<dynamic, dynamic> toJson() => {
    'id' : this._id,
    'user1' : this._user1.toJson(),
    'user2' : this._user2.toJson(),
    'chat' : this._chat == null ? null : jsonEncode(this._chat.map((model) => model.toJson).toList())
  };
}