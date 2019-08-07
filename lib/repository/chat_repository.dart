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
      // INSERT KEY TO BOTH USER
      database.child('user').child(room.user1.username).child('chats').child(room.id).set({
        'id' : room.id
      });
      database.child('user').child(room.user2.username).child('chats').child(room.id).set({
        'id' : room.id
      });

      // INSERT DETAIL USER IN THE ROOM CHAT
      database.child('room').child(room.id).set(room.toJson());
      return room.id;
    }
    on Exception{
      return '';
    }
  }
}