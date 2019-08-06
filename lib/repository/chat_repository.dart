import 'package:firebase_database/firebase_database.dart';

class ChatRepository {
  final DatabaseReference database = FirebaseDatabase.instance.reference().child('chat');

  Future<DataSnapshot> getListChat() async {
    return await database.once();
  }
}