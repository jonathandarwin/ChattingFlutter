import 'package:chatting_app/base/base_provider.dart';

class HomeProvider extends BaseProvider{
  int _page = 0;
  String _title = 'Friends';
  bool _isFabVisible = true;

  get page => _page;
  get title => _title;
  get isFabVisible => _isFabVisible;
  
  set page(int page){
    this._page = page;
    notifyListeners();
  }
  set title(String title){
    this._title = title;
    notifyListeners();
  }
  set isFabVisible(bool isFabVisible){
    this._isFabVisible = isFabVisible;
    notifyListeners();
  }
}