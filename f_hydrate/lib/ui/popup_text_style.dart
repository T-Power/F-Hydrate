import 'package:flutter/material.dart';

class TextPopup extends StatefulWidget {
  final String text;
  final bool isBold;

  TextPopup({Key? key, required this.text, required this.isBold})
      : super(key: key);

  @override
  _TextPopupState createState() => _TextPopupState();
}

class _TextPopupState extends State<TextPopup> {
  @override
  Widget build(BuildContext context) {
    if (widget.isBold) {
      return Text(widget.text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ));
    } else {
      return Text(widget.text,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 18,
          ));
    }
  }
}
