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
    // Use the Athlete to create the UI.
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
          title: Text(athlete.athleteFullName),
          actions: <Widget>[],
          backgroundColor: Colors.black),
      //content
      body: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
          top: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 10,
              child: Container(
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(athlete.athletePicture),
                  ),
                ),
              ),
            ),
            Text(
              athlete.athleteDescription,
              style: TextStyle(
                color: Colors.grey[100],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
