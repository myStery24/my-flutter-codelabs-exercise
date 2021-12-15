import 'package:flutter/material.dart';

import 'lab3_4/layout_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LayoutScreen(),
    );
  }
}
