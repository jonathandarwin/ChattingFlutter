import 'package:chatting_app/model/room.dart';
import 'package:chatting_app/model/user.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRepository {
  final DatabaseReference database = FirebaseDatabase.instance.reference();  
  

  Future<DataSnapshot> getRoomChat(User session) async {
    return await database.child('user').child(session.username).child('chats').once();
  }

  Future<DataSnapshot> getChat(String id) async {
    return await database.child('room').child(id).once();
  }

  String insertChat(Room room){
    try{
      String id = room.user1.username + room.user2.username;
      // INSERT KEY TO BOTH USER
      database.child('user').child(room.user1.username).child('chats').child(id).set({
        'id' : id
      });
      database.child('user').child(room.user2.username).child('chats').child(id).set({
        'id' : id
      });

      // INSERT DETAIL USER IN THE ROOM CHAT
      database.child('room').child(id).set(room.toJson());
      return id;
    }
    on Exception{
      return '';
    }
  }
}