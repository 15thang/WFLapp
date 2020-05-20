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
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Colors.black,
      title: Text(
        _title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}