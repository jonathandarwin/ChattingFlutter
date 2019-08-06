import 'package:chatting_app/app/home/profile/profile_provider.dart';
import 'package:chatting_app/app/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      builder: (context) => ProfileProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),    
          backgroundColor: Colors.lightBlue,      
        ),
        body: Center(
          child: Consumer<ProfileProvider>(
            builder: (context, provider, _) => FlatButton(
              onPressed: (){
                provider.logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => SplashLayout()
                  )
                );
              },
              child: Text('Logout'),
            )
          ),
        ),
      )
    );
  }
}