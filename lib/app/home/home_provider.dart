import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier{
  int _page = 0;

  get page => _page;
  
  set page(int page){
    this._page = page;
    notifyListeners();
  }
}