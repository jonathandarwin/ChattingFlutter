import 'package:chatting_app/app/home/home.dart';
import 'package:chatting_app/app/login/login.dart';
import 'package:chatting_app/app/splash/splash_provider.dart';
import 'package:flutter/material.dart';

class SplashLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    
    Future.delayed(Duration(milliseconds: 2000), (){
      SplashProvider _provider = SplashProvider();
      _provider.checkSession().then((value) {
        Widget widget;
        switch(value){
          case SplashProvider.GOTO_HOME :
            widget = HomeLayout();
            break;
          case SplashProvider.GOTO_LOGIN :
            widget = LoginLayout();
            break;            
        }

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, duration){
              return widget;
            },
            transitionDuration: Duration(microseconds: 1500)
          )
        );
      });
    });

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body : Center(
        child: Text(
          'Chatting',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0
          ),
        ),
      )
    );
  }
}