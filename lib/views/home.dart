import 'package:acemobile/components/home_card.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ace Dashboard",
          style: TextStyle(
            color: Color(0xFF4BCFFA),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(8.0),
        child: Column(
          children: [
            HomeCard(),
            HomeCard(),
          ],
        ),
      ),
    );
  }
}
