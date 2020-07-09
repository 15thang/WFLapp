import 'package:flutter/material.dart';

class EventSliverAppBar extends StatelessWidget {
  final String _title;

  const EventSliverAppBar(
    this._title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Colors.black,
      title: Row(
        children: <Widget>[
          Container(
            height:90,
            width: 90,
            decoration: BoxDecoration(
              image: new DecorationImage(
                  image: new NetworkImage(
                      'http://superfighter.nl/pics/wflicon.jpg'),
                  fit: BoxFit.fill),
            ),
          ),
          Text('  ' + 
              _title,
              style: TextStyle(color: Colors.white),
            ),
        ],
      ),
    );
  }
}
