import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wfl_app/model/athletes.dart';

class AthletesCompPage extends StatelessWidget {
  // Declare a field that holds the Athlete.
  final Athlete athlete;

  // In the constructor, require a Athlete.
  AthletesCompPage({Key key, @required this.athlete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return new GestureDetector(
            child: new Card(
              
            ),
          );
        },
        itemCount: 1,
      ),
    );
  }
}
