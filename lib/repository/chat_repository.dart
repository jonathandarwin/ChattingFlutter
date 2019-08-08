import 'package:chatting_app/model/chat.dart';
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

  // Future<DataSnapshot> getListChat(String id) async {    
  //   return await database.child('room').child(id).child('chat').orderByKey().once();
  // }

  Stream<Event> getListChat(String id) {
    return  database.child('room').child(id).child('chat').onChildAdded;
  }

  String insertRoomChat(Room room){
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

  bool insertChat(String id,Chat chat){
    try{
      database.child('room').child(id).child('chat').push().set(chat.toJson());
      return true;
    }
    on Exception{
      return false;
    }
  }
}