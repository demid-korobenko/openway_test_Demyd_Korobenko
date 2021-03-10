import 'package:flutter/material.dart';

class PinDigit extends StatelessWidget {

  final String value;
  final double width;

  PinDigit({this.value, this.width});

  @override
  Widget build(BuildContext context) {

    double _padding = width/10;

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: _padding),
        child: Material(
            elevation: 1,
            color: Colors.white, // Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(width/5),
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
                width: width-(_padding*2),
                height: width*1.2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FittedBox(fit: BoxFit.contain, child: Text(value)),
                ),
            ),
        ),
    );
  }


}