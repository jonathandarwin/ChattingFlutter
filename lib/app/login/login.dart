import 'package:chatting_app/app/home/home.dart';
import 'package:chatting_app/app/login/login_provider.dart';
import 'package:chatting_app/app/register/register.dart';
import 'package:chatting_app/util/focus_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class LoginLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      builder: (context) => LoginProvider(),
      child: SafeArea(  
        child: Scaffold(
          backgroundColor: Colors.lightBlue,
          body: Stack(
            children: <Widget>[
              // FORM              
              GestureDetector(
                onTap: () => FocusUtil.changeFocus(context),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(50.0),                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,                
                      children: <Widget>[
                        Expanded(
                          flex: 2,                    
                          child: Title(),
                        ),
                        Expanded(
                          flex: 4,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                TextFieldUsername(),
                                TextFieldPassword(),
                                ButtonLogin(),
                                TextRegister()
                              ],
                            ),
                          )
                        )
                      ],
                    ),
                  )
                ),
              ),              
              // LOADER
              Loader()
            ],
          )
        )
      ),      
    );
  }
}

class Loader extends StatelessWidget{
  Widget build(BuildContext context){
    return Consumer<LoginProvider>(
      builder: (context, provider, _){
        return Center(
          child: Visibility(
            visible: provider.isLoading,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,                  
            ),
          ),
        );
      },
    );
  }
}

class Title extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Text(
      'Chatting',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 30.0
      ),
    );
  }
}

class TextFieldUsername extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Consumer<LoginProvider>(
      builder: (context, provider, _){
        return TextField(          
          onChanged: (text) => provider.user.username = text,
          cursorColor: Colors.white,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(            
            labelText: 'Username',
            labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(                
                borderSide: BorderSide(
                  color: Colors.white
                )
              ),
              focusedBorder: OutlineInputBorder(                
                borderSide: BorderSide(
                  color: Colors.white
                )
              )
          ),
        );
      }
    );
  }
}

class TextFieldPassword extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Consumer<LoginProvider>(
      builder: (context, provider, _){
        return Container(
          margin: EdgeInsets.only(top: 10.0),
          child: TextField(          
            obscureText: true,
            cursorColor: Colors.white,            
            onChanged: (text) => provider.user.password = text,
            style: TextStyle(
              color: Colors.white,
              decorationColor: Colors.white,                            
            ),
            decoration: InputDecoration(
              labelText: 'Password',          
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(                
                borderSide: BorderSide(
                  color: Colors.white
                )
              ),
              focusedBorder: OutlineInputBorder(                
                borderSide: BorderSide(
                  color: Colors.white
                )
              )
            ),
          ),
        );
      }
    );
  }
}

class ButtonLogin extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Consumer<LoginProvider>(
      builder: (context, provider, _) {
        return Container(
          margin: EdgeInsets.all(10.0),
          child: FlatButton(                                
            onPressed: provider.isLoading ? null : (){              
              if(provider.validateInput()){
                // DO LOGIN
                provider.isLoading = true;
                provider.doLogin().then((value) {
                  provider.isLoading = false;

                  switch(value){
                    case LoginProvider.LOGIN_SUCCESS:
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeLayout()
                        )
                      );
                      break;
                    case LoginProvider.LOGIN_INCORRECT:
                      Toast.show('Incorrect username / password', context, duration: Toast.LENGTH_LONG);
                      break;
                  }                  
                });
              }
              else{
                Toast.show('Please input all the field', context, duration: Toast.LENGTH_LONG);
              }
              
            },
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white
              ),),
          ),
        );
      },
    );
  }
}

class TextRegister extends StatelessWidget{
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RegisterLayout()
          )
        );
      },
      child: Text(
        'Don\'t have an account? Sign up here.',
        style: TextStyle(
          color: Colors.blueGrey[100]
        ),
      ),
    );
  }
}