import 'package:chatting_app/app/home/friend/add_friend/add_friend.dart';
import 'package:chatting_app/app/home/friend/friend_dialog.dart';
import 'package:chatting_app/app/home/friend/friend_provider.dart';
import 'package:chatting_app/widget/no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:chatting_app/widget/loader.dart';

class FriendsLayout extends StatelessWidget{
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      builder: (context) => FriendsProvider(),      
      child: Scaffold(
        appBar: AppBar(
          title: Text('Friends'),    
          backgroundColor: Colors.lightBlue,
          actions: <Widget>[
            IconAdd()
          ],
        ),        
        body: ListFriend(),
      )
    );
  }  
}

class ListFriend extends StatelessWidget{
  @override
  Widget build(BuildContext context){      
    FriendsProvider _provider = Provider.of<FriendsProvider>(context);        
    _provider.getFriends();
    return Text('testing saja');
    // return FutureBuilder(
    //   future: _provider.getFriends(),
    //   initialData: null,
    //   builder: (context, snapshot){          
    //     if (snapshot.connectionState == ConnectionState.done)  {
    //       switch(snapshot.data){
    //         case FriendsProvider.LOAD_FRIEND_NO_DATA:
    //           return NoData();
    //           break;
    //         case FriendsProvider.LOAD_FRIEND_ERROR:
    //           Toast.show('Error. Please try again', context, duration: Toast.LENGTH_LONG);
    //           return NoData();
    //           break;  
    //         case FriendsProvider.LOAD_FRIEND_SUCCESS:
    //           return ListItem();
    //           break;
    //       }
    //     }

    //     return Loader();
    //   },
    // );        
  }
}

class ListItem extends StatelessWidget{  
  @override
  Widget build(BuildContext context){
    return Consumer<FriendsProvider>(
      builder: (context, provider, _){
        return ListView.separated(
          separatorBuilder: (context, i) => Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          itemCount: provider.listFriend.length,
          itemBuilder: (context, i) {            
            return ListTile(
              title: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(              
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextName(i),
                    TextUsername(i)
                  ],
                ),
              ),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => FriendDialog(provider, provider.listFriend[i])).then((value){
                  provider.getFriends();                    
                });
              },              
            );
          },
        );
      },
    );
  }
}

class TextName extends StatelessWidget{
  final int i;
  TextName(this.i);

  @override
  Widget build(BuildContext context){
    return Consumer<FriendsProvider>(
      builder: (context, provider, _) => Text(
        provider.listFriend[i].name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
      ),
    );
  }
}

class TextUsername extends StatelessWidget{
  final int i;
  TextUsername(this.i);

  @override
  Widget build(BuildContext context){
    return Consumer<FriendsProvider>(
      builder: (context, provider, _) => Text(
        provider.listFriend[i].username,
        style: TextStyle(
          color: Colors.grey
        ),
      ),
    );
  }
}

class IconAdd extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder : (_) => AddFriendLayout()
          )
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 15.0),
        child: Icon(Icons.add),
      ),
    );
  }
}