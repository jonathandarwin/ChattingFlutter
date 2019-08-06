import 'package:chatting_app/app/register/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RegisterLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(      
      builder: (context) => RegisterProvider(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.lightBlue,
          body: Stack(
            children: <Widget>[
              // FORM
              Center(
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
                              TextFieldName(),
                              TextFieldUsername(),
                              TextFieldPassword(),
                              ButtonRegister(),                                  
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                )
              ),   
              // LOADER
              Loader()
            ],
          )
        ),
      ),
    );
  }
}

class Loader extends StatelessWidget{
  Widget build(BuildContext context){
    return Consumer<RegisterProvider>(
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
      'Register',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 30.0
      ),
    );
  }
}

class TextFieldName extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Consumer<RegisterProvider>(
      builder: (context, provider, _){
        return TextField(          
          onChanged: (text) => provider.user.name = text,
          cursorColor: Colors.white,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(            
            labelText: 'Name',
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

class TextFieldUsername extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Consumer<RegisterProvider>(
      builder: (context, provider, _){
        return Container(
          margin: EdgeInsets.only(top: 10.0),
          child: TextField(          
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
          ),
        );
      }
    );
  }
}

class TextFieldPassword extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Consumer<RegisterProvider>(
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

class ButtonRegister extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Consumer<RegisterProvider>(
      builder: (context, provider, _) {
        return Container(
          margin: EdgeInsets.all(10.0),
          child: FlatButton(          
            onPressed: () {              
              provider.isLoading = true;
              provider.doRegister().then((value) {
                provider.isLoading = false;

                String message = '';
                switch(value){
                  case RegisterProvider.STATUS_SUCCESS:
                    print('Success');
                    message = 'Register Success';
                    break;
                  case RegisterProvider.STATUS_ERROR:                        
                    print('Error');
                    message = 'Erorr. Please try again.';
                    break;
                  case RegisterProvider.STATUS_EXISTS:
                    print('Exists');
                    message = "Username already exists";
                    break;
                  case RegisterProvider.STATUS_EMPTY:
                    print('Empty');
                    message = "Please input all the field";
                    break;
                }
                Toast.show(message, context, duration: Toast.LENGTH_LONG);                

                if(value == RegisterProvider.STATUS_SUCCESS){
                  Navigator.of(context).pop();
                }
              });              
            },
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        );
      },
    );
  }
}