import 'package:acemobile/views/home.dart';
import 'package:flutter/material.dart';

class AceApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ace Mobile",
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(primarySwatch: Colors.deepPurple),
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Home(),
    );
  }
}
