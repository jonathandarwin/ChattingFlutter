import 'package:chatting_app/app/home/chats/chats_provider.dart';
import 'package:chatting_app/app/room_chat/room_chat.dart';
import 'package:chatting_app/model/room.dart';
import 'package:chatting_app/util/datetime_util.dart';
import 'package:chatting_app/widget/list_divider.dart';
import 'package:chatting_app/widget/loader.dart';
import 'package:chatting_app/widget/no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatsLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      builder: (context) => ChatsProvider(),
      child: ListRoom()     
    );
  }
}

class ListRoom extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    ChatsProvider _provider = Provider.of<ChatsProvider>(context);
    return FutureBuilder(
      future: _provider.getRoomChat(),
      initialData: null,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.data == ChatsProvider.SUCCESS){
            return ListItem();
          }
          else if (snapshot.data == ChatsProvider.NO_DATA){
            return NoData();
          }
        }
        return Loader();
      },
    );
  }
}

class ListItem extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    ChatsProvider _provider = Provider.of<ChatsProvider>(context);
    return ListView.separated(
      separatorBuilder: (context, i) => ListDivider(),
      itemCount: _provider.listRoom.length,
      itemBuilder: (context, i){
        Room room = _provider.listRoom[i];
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: ListTile(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RoomChatLayout(room, _provider.session.username == room.user1.username ? room.user2 : room.user1)
                )
              );
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,              
              children: <Widget>[
                // IMAGE
                Container(      
                  margin: EdgeInsets.only(right: 15.0),
                  child: PhysicalModel(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(100.0),      
                    child: Container(        
                      padding: EdgeInsets.all(5.0),        
                      child: Icon(Icons.person, size: 50.0,),
                    ) 
                  ),
                ),
                // CHAT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _provider.session.username == room.user1.username ? room.user2.name : room.user1.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        room.chat[room.chat.length-1].chat,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                // TIME
                Text(
                  getTextDateTime(room),
                  style: TextStyle(
                    color: Colors.grey
                  ),
                )
              ],
            ),
          )
        );               
      },
    );
  }

  String getTextDateTime(Room room){
    int compare = DatetimeUtil.compareDate(DateTime.now().toString(), room.chat[room.chat.length-1].datetime);
    if(compare == DatetimeUtil.SAME_DATE){
      return DatetimeUtil.convertTimeToView(room.chat[room.chat.length-1].datetime);
    }
    else if(compare == DatetimeUtil.DATE_IS_GREATER){
      return DatetimeUtil.convertDate(room.chat[room.chat.length-1].datetime, DatetimeUtil.DATE_FORMAT_SHORT);
    }
    return '';
  }
}