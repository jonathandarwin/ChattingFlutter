import 'package:chatting_app/app/home/chats/chats.dart';
import 'package:chatting_app/app/home/friend/add_friend/add_friend.dart';
import 'package:chatting_app/app/home/friend/friend.dart';
import 'package:chatting_app/app/home/home_provider.dart';
import 'package:chatting_app/app/home/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatelessWidget{  
  final List<Widget> _listLayout = <Widget>[
    FriendsLayout(),
    ChatsLayout(),
    ProfileLayout()
  ];

  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      builder: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title:  Consumer<HomeProvider>(
                  builder: (context, provider, _) => Text(provider.title),
                ),
                backgroundColor: Colors.lightBlue,
              ),
              body: _listLayout[provider.page],
              floatingActionButton: FloatingButtonAdd(),
              bottomNavigationBar: BottomNavigation(),
            ),
          );
        },
      )
    );
  }
}

class FloatingButtonAdd extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    HomeProvider _provider = Provider.of<HomeProvider>(context, listen:false);

    return Visibility(
      visible: _provider.isFabVisible,
      child: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddFriendLayout()
            )
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    HomeProvider _provider = Provider.of<HomeProvider>(context, listen:false);

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          title: Text('Friends')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          title: Text('Chats')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile')
        ),
      ],
      currentIndex: _provider.page,
      onTap: (value){
        // CHANGE PAGE
        _provider.isFabVisible = value == 0 ? true : false;            
        _provider.page = value;
        _provider.title = value == 0 ? 'Friends' : value == 1 ? 'Chats' : 'Profile';
      }
    );
  }
}