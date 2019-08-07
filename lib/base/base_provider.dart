import 'package:flutter/foundation.dart';

class BaseProvider with ChangeNotifier{
  refresh(){
    notifyListeners();
  }
}