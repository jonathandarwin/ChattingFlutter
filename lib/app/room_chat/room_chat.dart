import 'package:chatting_app/app/room_chat/room_chat_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomChatLayout extends StatelessWidget{    
  @override
  Widget build(BuildContext context){    
    return ChangeNotifierProvider(
      builder: (context) => RoomChatProvider(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('asdf'),
          ),
        ),
      ),
    );
  }
}