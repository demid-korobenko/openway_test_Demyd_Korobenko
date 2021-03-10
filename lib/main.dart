import 'package:flutter/material.dart';
import 'package:openway_test/models/pinCode.dart';
import 'package:provider/provider.dart';
import 'pages/codeInputPage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PinCodeModel>(
          create: (context) => PinCodeModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenWay Test App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF2F2F2),
        shadowColor: Colors.grey,
        primarySwatch: Colors.grey,
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
            headline1: TextStyle(color: Color(0xFF484848), fontSize: 28),
            headline2: TextStyle(color: Color(0xFF484848), fontSize: 20),
            bodyText2: TextStyle(color: Color(0xff6c757d), fontSize: 16)
        ),
        buttonTheme: ButtonThemeData(
          buttonColor:
          Colors.blue,
          highlightColor: Colors.blue,
          disabledColor: Colors.grey,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      home: CodeInputPage(),
    );
  }
}

