import 'package:chatting_app/model/user.dart';
import 'package:firebase_database/firebase_database.dart';

class FriendRepository{
  final database = FirebaseDatabase.instance.reference().child('user');

  Future<DataSnapshot> getFriend(String id) async {
    return await database.child(id).child('friends').once();
  }

  Future<DataSnapshot> getFriendById(String username, String id) async {
    return await database.child(username).child('friends').child(id).once();
  }

  bool addFriends(User session, User user){
    try{
      database.child(session.username).child('friends').child(user.username).set(user.toJson());
      database.child(user.username).child('friends').child(session.username).set(session.toJson());
      return true;
    }
    on Exception{
      return false;
    }
  }

  bool deleteFriends(User session, User user){
    try{
      database.child(session.username).child('friends').child(user.username).remove();
      database.child(user.username).child('friends').child(session.username).remove();
      return true;
    }
    on Exception{
      return false;
    }
  }
}