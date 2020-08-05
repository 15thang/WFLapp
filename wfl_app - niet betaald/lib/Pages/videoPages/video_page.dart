import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Videos extends StatefulWidget {
  const Videos({Key key}) : super(key: key);

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(
                        'http://superfighter.nl/pics/wflicon.jpg'),
                    fit: BoxFit.fill),
              ),
            ),
            Text(
              ' Videos',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Text('Premium only', style: TextStyle(color: Colors.white, fontSize: 15),),
      ),
    );
  }
}
