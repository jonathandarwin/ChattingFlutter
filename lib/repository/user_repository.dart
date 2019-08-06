import 'package:chatting_app/model/user.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository{
  final database = FirebaseDatabase.instance.reference().child('user');

  bool insertUser(User user){
    try{
      database.child(user.username).set(user.toJson());
      return true;
    }
    on Exception{
      return false;
    }    
  }

  Future<DataSnapshot> getUser(User user) async {
    return await database.orderByChild('username').equalTo(user.username).once();
  }
}