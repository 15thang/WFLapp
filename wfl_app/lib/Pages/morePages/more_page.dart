import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/more.dart';

class Morepage extends StatefulWidget {
  const Morepage({Key key}) : super(key: key);

  @override
  _Morepage createState() => _Morepage();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _Morepage extends State<Morepage> {
  List<Morepage> _notes = List<Morepage>();

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
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        children: <Widget>[],
                                      ),
                                    ),
                                  )
                                ],
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
                              height: 10,
                              color: Colors.redAccent[700],
                              margin: EdgeInsets.only(left: 8),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 10,
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
                                'Other pages:',
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
                              child: Text(
                                'Official website: https://wfltickets.com/',
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
                              child: Text(
                                'Buy tickets here: https://www.eventbrite.nl/o/world-fighting-league-28797683507',
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
                              child: Text(
                                'Facebook: https://www.facebook.com/WorldFightingLeague',
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
                              child: Text(
                                'Instagram: https://www.instagram.com/worldfightingleagueofficial/7',
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
                              child: Text(
                                'YouTube: https://www.youtube.com/channel/UCCXoNOI32UE3DtK9fR4GDfA',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Divider(color: Colors.black)
                          ],
                        ),
                        margin: EdgeInsets.only(left: 8, right: 8),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 10,
                              color: Colors.redAccent[700],
                              margin: EdgeInsets.only(left: 8),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 10,
                              color: Colors.blue[900],
                              margin: EdgeInsets.only(right: 8),
                            ),
                          ),
                        ],
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
