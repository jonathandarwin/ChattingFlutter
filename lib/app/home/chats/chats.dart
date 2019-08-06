import 'package:chatting_app/app/home/chats/chats_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatsLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      builder: (context) => ChatsProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chats'),    
          backgroundColor: Colors.lightBlue,      
        ),
        body: Center(
          child: Text('Chats'),
        ),
      )
    );
  }
}