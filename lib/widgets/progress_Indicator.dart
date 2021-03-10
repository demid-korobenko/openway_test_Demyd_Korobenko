import 'package:flutter/material.dart';

class ProgressIndicator {
  bool _isShowing = false;
  BuildContext _context;

  ProgressIndicator(
      BuildContext buildContext) {
    _context = buildContext;

  }

  void hide() async {
      Navigator.of(_context).pop();
  }

  void show() {

      //debugPrint('ProgressIndicator shown');
      showDialog<dynamic>(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _context = context;
          return _IndicatorWidget();
        },
      );
  }




}


class _IndicatorWidget extends StatelessWidget {

  Future<bool> _onBackButtonPressed() {
    // Do nothing. Disable exit progress bar with Back Button
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
        onWillPop: _onBackButtonPressed,
        child: Center(
          child: SizedBox(
              width: 60.0,
              height: 60.0,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ) //Image.asset('assets/double_ring_loading_io.gif'),
          ),
        ));
  }

}