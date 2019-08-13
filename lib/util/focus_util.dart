import 'package:flutter/material.dart';

class FocusUtil{
  static changeFocus(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }
}