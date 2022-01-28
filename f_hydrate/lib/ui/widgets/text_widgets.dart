import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  late final VoidCallback callback;
  late final String? Function(String?) validationCallback;

  InputField({
    Key? key,
    required this.title,
    required this.controller,
    this.icon = Icons.bug_report,
    this.text = "",
    this.isSecret = false,
    this.readOnly = false,
    this.visible = true,
    this.useFormField = false,
    this.textInputType = TextInputType.multiline,
    VoidCallback? callback,
    String? Function(String?)? validationCallback,
  }) : super(key: key) {
    this.callback = callback ?? () => {};
    this.validationCallback = validationCallback ??
        (String) {
          return null;
        };
  }

  final String title;
  final String text;
  final IconData icon;
  final TextEditingController controller;

  final bool isSecret;
  final bool readOnly;
  final bool visible;
  final bool useFormField;

  final TextInputType textInputType;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            widget.useFormField
                ? TextFormField(
                    controller: widget.controller,
                    readOnly: widget.readOnly,
                    obscureText: widget.isSecret,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    onChanged: (test) {
                      setState(() {
                        widget.callback();
                      });
                    },
                    validator: widget.validationCallback,
                    maxLines: widget.isSecret ? 1 : null,
                    keyboardType: widget.isSecret
                        ? TextInputType.text
                        : widget.textInputType,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Theme.of(context).primaryColor,
                      filled: true,
                      prefixIcon: Icon(
                        widget.icon,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ))
                : TextField(
                    controller: widget.controller,
                    readOnly: widget.readOnly,
                    keyboardType: widget.isSecret
                        ? TextInputType.text
                        : widget.textInputType,
                    obscureText: widget.isSecret,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    onChanged: (text) {
                      setState(() {
                        widget.validationCallback(text);
                        widget.callback();
                      });
                    },
                    maxLines: widget.isSecret ? 1 : null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Theme.of(context).primaryColor,
                      filled: true,
                      prefixIcon: Icon(
                        widget.icon,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
