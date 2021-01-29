import 'package:e9pay_sl_service/views/homeView.dart';
import 'package:flutter/material.dart';
import 'package:e9pay_sl_service/views/form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E9pay Sri Lanka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormView(),
    );
  }
}