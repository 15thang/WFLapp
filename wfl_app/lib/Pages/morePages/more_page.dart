import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/homepage.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key key}) : super(key: key);

  @override
  _MorePage createState() => _MorePage();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _MorePage extends State<MorePage> {
  List<Homepage> _notes = List<Homepage>();

  DateTime startTime = DateTime(2020, 07, 25);
  Duration remaining = DateTime.now().difference(DateTime.now());
  Timer t;
  int days = 0, hrs = 0, mins = 0, sec = 0;

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, forceSafariVC: true);
    } else {
      print("Can't Launch");
    }
  }

  Future<List<Homepage>> fetchNotes() async {
    var url = 'http://superfighter.nl/APP_output_homepage.php';

    var response = await http.get(url);

    var notes = List<Homepage>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);

      for (var noteJson in notesJson) {
        notes.add(Homepage.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
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
    return new Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, index) => new Container(
                color: Colors.black,
                child: Container(
                  alignment: Alignment.center,
                  height: 25,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8, right: 12, top: 15, bottom: 17),
                              child: Row(
                                children: <Widget>[],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              childCount: 1,
            ),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, index) => new ListTile(
                title: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 3,
                              color: Colors.redAccent[700],
                              margin: EdgeInsets.only(left: 8),
                            ),
                          ),
                          Container(
                            height: 55,
                            width: 170,
                            decoration: BoxDecoration(
                              image: new DecorationImage(
                                  image: new NetworkImage(
                                      'https://wfltickets.com/wp-content/uploads/2018/08/world-fighting-league-logo.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 3,
                              color: Colors.blue[900],
                              margin: EdgeInsets.only(right: 8),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 10000,
                              child: Text(
                                'Other Pages:',
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Divider(color: Colors.black)
                          ],
                        ),
                        margin: EdgeInsets.only(left: 8, right: 8),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 10000,
                              child: RaisedButton(
                                onPressed: () {
                                  launchURL('https://wfltickets.com/');
                                },
                                child: Text(
                                  'Official Website',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                color: Colors.red[800],
                              ),
                            ),
                            Divider(color: Colors.black)
                          ],
                        ),
                        margin: EdgeInsets.only(left: 8, right: 8),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 10000,
                              child: RaisedButton(
                                onPressed: () {
                                  launchURL(
                                      'https://www.eventbrite.nl/o/world-fighting-league-28797683507');
                                },
                                child: Text(
                                  'Buy Tickets',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                color: Colors.green[800],
                              ),
                            ),
                            Divider(color: Colors.black)
                          ],
                        ),
                        margin: EdgeInsets.only(left: 8, right: 8),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 10000,
                              child: RaisedButton(
                                onPressed: () {
                                  launchURL(
                                      'https://www.facebook.com/WorldFightingLeague');
                                },
                                child: Text(
                                  'Facebook',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                color: Colors.blue[800],
                              ),
                            ),
                            Divider(color: Colors.black)
                          ],
                        ),
                        margin: EdgeInsets.only(left: 8, right: 8),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 10000,
                              child: RaisedButton(
                                onPressed: () {
                                  launchURL(
                                      'https://www.instagram.com/worldfightingleagueofficial/');
                                },
                                child: Text(
                                  'Instagram',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                color: Colors.black12,
                              ),
                            ),
                            Divider(color: Colors.black)
                          ],
                        ),
                        margin: EdgeInsets.only(left: 8, right: 8),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 10000,
                              child: RaisedButton(
                                onPressed: () {
                                  launchURL(
                                      'https://www.youtube.com/channel/UCCXoNOI32UE3DtK9fR4GDfA');
                                },
                                child: Text(
                                  'YouTube',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                color: Colors.red,
                              ),
                            ),
                            Divider(color: Colors.black)
                          ],
                        ),
                        margin: EdgeInsets.only(left: 8, right: 8),
                      ),
                    ],
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
