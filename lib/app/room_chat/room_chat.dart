import 'package:chatting_app/app/room_chat/room_chat_provider.dart';
import 'package:chatting_app/model/room.dart';
import 'package:chatting_app/model/user.dart';
import 'package:chatting_app/util/session_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomChatLayout extends StatelessWidget{    
  final Room room;
  RoomChatLayout(this.room);

  @override
  Widget build(BuildContext context){
    User session = User();    
    return ChangeNotifierProvider(
      builder: (context) => RoomChatProvider(),
      child: FutureBuilder(        
        future: SessionUtil.loadUserData(),
        initialData: null,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              session = snapshot.data;
              return SafeArea(
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    title: Text(session.username == room.user1.username ? room.user2.name : room.user1.name),
                  ),
                  body: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 9,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: BottomLayout(),
                          )
                        ],
                      ),
                    ),
                ),
              );
            }
          }
          return CircularProgressIndicator();
        },
      )
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