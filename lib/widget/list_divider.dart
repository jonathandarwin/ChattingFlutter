import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListDivider extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Divider(
        color: Colors.grey,
      ),
    );
  }
}