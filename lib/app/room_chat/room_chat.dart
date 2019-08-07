import 'package:chatting_app/app/room_chat/room_chat_provider.dart';
import 'package:chatting_app/model/room.dart';
import 'package:chatting_app/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomChatLayout extends StatelessWidget{    
  final Room room;
  final User user;
  RoomChatLayout(this.room, this.user);

  @override
  Widget build(BuildContext context){    
    return ChangeNotifierProvider(
      builder: (context) => RoomChatProvider(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(user.name),
            backgroundColor: Colors.lightBlue,
          ),
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: Container(
                    
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: BottomLayout(),
                ),                                      
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Row(      
      children: <Widget>[
        Expanded(
          flex: 8,
          child: TextInput(),
        ),
        Expanded(
          flex: 2,
          child: ButtonSend(),
        )
      ],
    );
  }
}

class TextInput extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return TextField(
      onChanged: (text){},
      decoration: InputDecoration(
        hintText: 'Type a message'
      ),
    );
  }
}

class ButtonSend extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return FlatButton(
      onPressed: (){},
      child: Text('Send'),
    );
  }
}