import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:openway_test/widgets/resultDialog.dart';
import 'package:openway_test/widgets/progress_Indicator.dart' as indicator;

class PinCodeModel extends ChangeNotifier {
  String _value = '';
  int _length = 4;
  bool _isVerified = false;

  String getValue() {return this._value;}

  int length() {return this._length;}

  bool isVerified() {return _isVerified;}

  void setValue(String value) {
    this._value = value;
    _isVerified = false;
    notifyListeners();
  }

  void reset() {
    this._value = '';
    _isVerified = false;
    notifyListeners();
  }

  void verify(context) {
    indicator.ProgressIndicator _progressIndicator = indicator.ProgressIndicator(context);
    String _codeAcceptedMessage = 'Congrats! you pass';
    String _codeRefusedMessage = 'Ups... try again';
    String _incorrectCodeMessage = 'Entered code is incomplete\nPlease enter ${this._length}-digits code';

    String _message;

    if (this._value.length < this._length) {
      showDialog<String>(
          context: context,
          builder: (context) {return ResultDialog(false, _incorrectCodeMessage);}
      );
      return;
    }

    _progressIndicator.show();

    Future.delayed(Duration(seconds: 1), (){
      bool _result = _value == '1111';

      _progressIndicator.hide();

      if (!_result) {
        _message = _codeRefusedMessage;
        reset();
      } else {
        _isVerified = true;
        _message = _codeAcceptedMessage;
      }

      notifyListeners();

      showDialog<String>(
          context: context,
          builder: (context) {return ResultDialog(_result, _message);}
      );

    });

//    return _value == '1111';
  }

}