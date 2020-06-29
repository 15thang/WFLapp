import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  DateTime startTime = DateTime(2020, 07, 25);
  Duration remaining = DateTime.now().difference(DateTime.now());
  Timer t;
  int days = 0, hrs = 0, mins = 0, sec = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    t = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remaining = DateTime.now().difference(startTime);
        mins = 60 - remaining.inMinutes;
        sec = 60 - remaining.inSeconds;
        hrs = mins >= 60 ? mins ~/ 60 : 0;
        days = hrs >= 24 ? hrs ~/ 24 : 0;
        hrs = hrs % 24;
        hrs = hrs - 1;
        mins = mins % 60;
        sec = sec % 60;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          AppBar(
            title: Text(
                'COUNTDOWN ' +
                    days.toString().padLeft(2, '0') +
                    ':' +
                    hrs.toString().padLeft(2, '0') +
                    ':' +
                    mins.toString().padLeft(2, '0') +
                    ':' +
                    sec.toString().padLeft(2, '0'),
                style: TextStyle(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
