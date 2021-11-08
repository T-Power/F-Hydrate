import 'package:flutter/material.dart';

class NotImplementedWidget extends StatefulWidget {
  const NotImplementedWidget({Key? key}) : super(key: key);

  @override
  _NotImplementedWidgetState createState() => _NotImplementedWidgetState();

}

class _NotImplementedWidgetState extends State<NotImplementedWidget> {

  @override
  Widget build(BuildContext context) {
    // throw UnimplementedError();
    String widgetKey = "undefined";
    try{
      widgetKey = widget.key.toString();
    }catch(err){
      print(err);
    }
    String message = 'The widget $widgetKey is not implemented yet!';
    return Text(message);
  }

}