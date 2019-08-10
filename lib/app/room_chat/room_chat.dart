import 'package:chatting_app/app/room_chat/room_chat_provider.dart';
import 'package:chatting_app/model/chat.dart';
import 'package:chatting_app/model/room.dart';
import 'package:chatting_app/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
          body: RoomInfo(
            room: room,
            user: user,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 15,
                    child: Container(                      
                      child: ListChat()
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BottomLayout(),
                  ),                                      
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}

class RoomInfo extends InheritedWidget{
  final Room room;
  final User user;

  RoomInfo({
    this.room,
    this.user,
    Widget child
  }) : super(child : child);

  static RoomInfo of(BuildContext context) => context.inheritFromWidgetOfExactType(RoomInfo) as RoomInfo;

  bool updateShouldNotify(RoomInfo oldWidget) => oldWidget.room != room;
}

class ListChat extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    RoomChatProvider _provider = Provider.of<RoomChatProvider>(context, listen:false);
    RoomInfo _roomInfo = RoomInfo.of(context);
    _provider.getListChat(_roomInfo.room.id);
    return ListItem();
  }
}

class ListItem extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    RoomChatProvider _provider = Provider.of<RoomChatProvider>(context);
    RoomInfo _roomInfo = RoomInfo.of(context);    

    SchedulerBinding.instance.addPostFrameCallback((_) {
      // SET TO THE BOTTOM
      _provider.scrollController.animateTo(
        _provider.scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut
      );        
    });

    return ListView.separated(
      controller: _provider.scrollController,      
      shrinkWrap: true,      
      separatorBuilder: (context, i) => Padding(
        padding: EdgeInsets.all(10.0),
      ),
      itemCount: _provider.listChat.length,
      itemBuilder: (context, i){
        Chat chat = _provider.listChat[i];                
        if(chat.username == _roomInfo.user.username){
          // LEFT SIDE          
          return LeftHandChat(chat);
        }
        else {
          // RIGHT SIDE
          return RightHandChat(chat);
        }
      },
    );
  }
}

class LeftHandChat extends StatelessWidget {
  final Chat _chat;
  LeftHandChat(this._chat);

  @override
  Widget build(BuildContext context){    
    RoomInfo _roomInfo = RoomInfo.of(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container( 
        margin: EdgeInsets.only(left: 5.0, top:5.0, bottom:5.0),
        child: Row(          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // IMAGE
            Container(      
              margin: EdgeInsets.only(right: 10.0),
              child: PhysicalModel(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(100.0),      
                child: Container(        
                  padding: EdgeInsets.all(5.0),        
                  child: Icon(Icons.person, size: 30.0,),
                ) 
              ),
            ),
            // MESSAGE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _roomInfo.user.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Material(            
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.blueAccent[100],
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(_chat.chat),
                    ),
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }
}

class RightHandChat extends StatelessWidget{
  final Chat _chat;
  RightHandChat(this._chat);

  @override
  Widget build(BuildContext context){    
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(right: 5.0, top:2.0, bottom:2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'Me',
              style: TextStyle(
                fontWeight: FontWeight.bold,              
              ),
            ),
            Container(
              child: Material(            
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.greenAccent[100],
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(_chat.chat),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

class BottomLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(      
      child: Row(      
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
      ),
    );
  }
}

class TextInput extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    RoomChatProvider _provider = Provider.of<RoomChatProvider>(context, listen:false);

    return TextField(
      controller: _provider.textController,
      keyboardType: TextInputType.multiline,      
      onChanged: (text) => _provider.message = text,
      decoration: InputDecoration(
        hintText: 'Type a message'
      ),
    );
  }
}

class ButtonSend extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    RoomChatProvider _provider = Provider.of<RoomChatProvider>(context, listen:false);
    final RoomInfo _roomInfo = RoomInfo.of(context);

    return FlatButton(
      onPressed: (){  
        _provider.isRefresh = true;      
        _provider.insertChat(_roomInfo.room, _roomInfo.user).then((value){                    
          _provider.textController.text = '';
        });        
        
      },
      child: Text('Send'),
    );
  }
}