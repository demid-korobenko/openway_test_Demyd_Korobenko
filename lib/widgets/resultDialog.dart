import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class ResultDialog extends StatelessWidget {
  bool _result;
  String _message;

  ResultDialog(bool result, String message) {this._result = result; this._message = message;}

  @override
  Widget build(BuildContext context) {

    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(_result? 'Success': 'Failed'),
        content: Text(_message),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              'Ok',
            ),
            onPressed: (){Navigator.of(context).pop();},
          ),
        ],
      );
    }
    return AlertDialog(
      title: Text(_result? 'Success': 'Failed',
        style: Theme.of(context).textTheme.headline2,
      ),
      content: Text(_message, style: Theme.of(context).textTheme.bodyText2,),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: (){Navigator.of(context).pop();},
        ),
      ],
    );
  }


  }

