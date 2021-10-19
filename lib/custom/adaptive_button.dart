import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptiveButon extends StatelessWidget {
  final String buttonText;
  final Function handler;

  const AdaptiveButon({this.buttonText, this.handler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            child: CupertinoButton(
              color: Theme.of(context).primaryColor,
              onPressed: handler,
              child: FittedBox(child: Text(buttonText)),
            ),
          )
        : ElevatedButton(
            onPressed: handler,
            child: Text(buttonText),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              onPrimary: Theme.of(context).colorScheme.onSecondary,
            ),
          );
  }
}
