import 'package:blink/pages/Chat.dart';
import 'package:blink/pages/Home.dart';
import 'package:blink/pages/Login.dart';
import 'package:blink/pages/OrderSubmitted.dart';
import 'package:blink/pages/Payment.dart';
import 'package:blink/pages/Signup.dart';
import 'package:flutter/material.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        fontFamily: 'shabnam',
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return PaymentPage(sum: "120000",);
  }
}