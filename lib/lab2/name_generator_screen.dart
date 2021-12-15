import 'package:flutter/material.dart';

import 'random_words.dart';


class NameGeneratorScreen extends StatelessWidget {
  const NameGeneratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orangeAccent,
          foregroundColor: Colors.black,
        ),
      ),
      home: RandomWords(),
    );
  }
}


