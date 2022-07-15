import 'package:acemobile/views/home.dart';
import 'package:flutter/material.dart';

class AceApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ace Mobile",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: Home(),
    );
  }
}
