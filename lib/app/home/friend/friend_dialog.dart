import 'package:chatting_app/app/room_chat/room_chat.dart';
import 'package:chatting_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app/app/home/friend/friend_provider.dart';
import 'package:toast/toast.dart';

class FriendDialog extends StatelessWidget{
  final User user;
  final FriendsProvider provider;
  FriendDialog(this.provider, this.user);

  @override
  Widget build(BuildContext context){
    return UserInfo(
      user: user,      
      provider: provider,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          //BACKGROUND
          Container(
            color: Colors.white,
            width: 300.0,
            height: 250.0,
          ),
          // DATA
          Container(
            margin: EdgeInsets.only(bottom: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Picture(),
                SizedBox(height: 20.0,),
                DataContainer()
              ],
            ),
          ),          
        ],
      )
    );               
  }
}

class UserInfo extends InheritedWidget{
  final User user;
  final FriendsProvider provider;
  UserInfo({this.user, this.provider, Widget child}) : super(child : child);

  static UserInfo of(BuildContext context) => context.inheritFromWidgetOfExactType(UserInfo) as UserInfo;

  bool updateShouldNotify(UserInfo oldWidget) => oldWidget.user != user;
}

class Picture extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(      
      child: PhysicalModel(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(100.0),      
        child: Container(        
          padding: EdgeInsets.all(20.0),        
          child: Icon(Icons.person, size: 100.0,),
        ) 
      ),
    );
  }
}

class DataContainer extends StatelessWidget{  
  @override
  Widget build(BuildContext context){    
    final UserInfo _userInfo = UserInfo.of(context);
    
    return Column(
      children: <Widget>[
        TextName(_userInfo.user.name),
        TextUsername(_userInfo.user.username),
        SizedBox(height: 50.0,),
        Row(
          children: <Widget>[
            IconChat(),            
            IconDelete()
          ],
        )
      ],
    );
  }
}

class TextName extends StatelessWidget{
  final String name;
  TextName(this.name);

  @override
  Widget build(BuildContext context){
    return Material(
      child: Text(
        name,
        style: TextStyle(        
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
      ),
    );
  }
}

class TextUsername extends StatelessWidget{
  final String username;
  TextUsername(this.username);

  @override
  Widget build(BuildContext context){
    return Material(
      child: Text(
        username,
        style: TextStyle(
          color: Colors.grey
        ),
      ),
    );
  }
}

class IconChat extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final UserInfo _userInfo = UserInfo.of(context);
    
    return Expanded(
      child: GestureDetector(
        onTap: (){
          _userInfo.provider.getRoomChat(_userInfo.user).then((id){
            if(id != ''){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RoomChatLayout()
                )
              );
            }
            else{
              Toast.show('Error. Please try again', context);
            }
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.chat,            
            ),
            Material(
              child: Text(
                'Chat'
              ),
            )
          ],
        ),
      )
    );
  }
}

class IconDelete extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final UserInfo _userInfo = UserInfo.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: (){
          _userInfo.provider.deleteFriend(_userInfo.user).then((value){
            if(value){
              Toast.show('Success', context, duration: Toast.LENGTH_LONG);
              Navigator.of(context).pop();
            }
            else{
              Toast.show('Error. Please try again', context, duration: Toast.LENGTH_LONG);
            }
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.delete,            
            ),
            Material(
              child: Text(
                'Delete'
              ),
            )
          ],
        ),
      )
    );
  }
}