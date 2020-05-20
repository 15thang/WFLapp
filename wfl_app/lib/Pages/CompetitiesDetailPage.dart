/*import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wfl_app/model/event.dart';

class CompetitiesDetailPage extends StatelessWidget {
  // Declare a field that holds the Event.
  final Event event;

  // In the constructor, require a Event.
  CompetitiesDetailPage({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Event to create the UI.
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
          title: Text(event.title),
          actions: <Widget>[],
          backgroundColor: Colors.red[900]),
      //content
      body: Container(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
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
                width: 1000,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(event.imageUrl),
                  ),
                ),
              ),
            ),
            Text(
              event.description,
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
*/