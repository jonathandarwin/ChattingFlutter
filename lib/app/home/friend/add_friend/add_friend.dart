import 'package:chatting_app/app/home/friend/add_friend/add_friend_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddFriendLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      builder: (context) => AddFriendProvider(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Add Friend'),
            backgroundColor: Colors.lightBlue,
          ),
          body:  SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: Stack(                
                children: <Widget>[                                                      
                  Column(
                    children: <Widget>[
                      Search(),                
                      Result()
                    ],
                  ),                  
                  Loading(),
                ],
              )
            ),
          )
        ),
      ) 
    );
  }
}

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Consumer<AddFriendProvider>(
      builder: (context, provider, _) => Container(
        child: Center(        
          child: Visibility(
            visible: provider.loading,
            child: CircularProgressIndicator()
          ),
        ),
      )
    );
  }
}

class Search extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    AddFriendProvider _provider = Provider.of<AddFriendProvider>(context, listen:false);
    return Container(
      child: Row(
        children: <Widget>[
          // TEXT FIELD
          Expanded(
            child: TextField(
              onChanged: (text) => _provider.search = text,
              decoration: InputDecoration(
                labelText: 'Search by Username'
              ),
            ),
          ),
          // BUTTON SEARCH
          FlatButton(
            onPressed: (){
              _provider.loading = true;
              _provider.searchUser().then((value){
                _provider.loading = false;                  
              });
            },
            child: Text('Search'),
          )
        ],        
      ),
    );
  }
}

class Result extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Consumer<AddFriendProvider>(
      builder: (context, provider, _) => Container(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            Text(
              provider.user.name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25.0
              ),
            ),
            Text(
              provider.user.username,
              style: TextStyle(
                color: Colors.grey,                            
              ),
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              child: Stack(
                children: <Widget>[
                  // BUTTON
                  Visibility(            
                    visible: provider.buttonVisibility,
                    child: RaisedButton(            
                      onPressed: (){
                        provider.addFriend().then((value) {
                          switch(value){
                            case AddFriendProvider.ADD_FRIEND_SUCCESS:
                              Toast.show('Add Success', context, duration: Toast.LENGTH_LONG);
                              break;
                            case AddFriendProvider.ADD_FRIEND_ERROR:
                              Toast.show('Error. Please try again', context, duration: Toast.LENGTH_LONG);
                              break;
                          }
                        });
                      },
                      child: Text(
                        'Add Friend',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      color: Colors.lightBlue,            
                    ),
                  ),
                  // TEXT MESSAGE
                  Text(                      
                    provider.message,
                    textAlign: TextAlign.center,
                    style : TextStyle(
                      color: Colors.redAccent,
                      fontStyle: FontStyle.italic
                    )
                  ),           
                ],
              ),
            )      
          ],
        ),
      )
    );
  }
}