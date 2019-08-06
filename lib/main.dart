import 'package:chatting_app/app/splash/splash.dart';
import 'package:flutter/material.dart';

void main() => runApp(Main());

class Main extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Chatting App",
      home: SafeArea(
        child: SplashLayout(),
      ),
    );
  }
}