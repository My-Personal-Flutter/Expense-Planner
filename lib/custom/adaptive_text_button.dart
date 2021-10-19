import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptiveTextButton extends StatelessWidget {
  final String buttonText;
  final Function handler;

  const AdaptiveTextButton({this.buttonText, this.handler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : TextButton(
            style:
                TextButton.styleFrom(primary: Theme.of(context).primaryColor),
            onPressed: handler,
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
