import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/Pages/SearchPage.dart';
import 'package:wfl_app/model/homepage.dart';
import 'athletePages/athlete_detail_page.dart';
import 'eventPages/event_detail_page.dart';
import 'videoPages/video_live_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _HomePage extends State<HomePage> {
  List<Homepage> _notes = List<Homepage>();

  Timer t;
  int days = 0, hrs = 0, mins = 0, sec = 0, sum = 1;
  int onlyOne = 30;

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
        onlyOne = int.parse(_notes[1].count);
        startTimer();
      });
    });
    super.initState();
  }

  startTimer() async {
    t = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime startTime = DateTime(
          int.parse(_notes[1].event1Year),
          int.parse(_notes[1].event1Month),
          int.parse(_notes[1].event1Day),
          int.parse(_notes[1].event1Hour),
          int.parse(_notes[1].event1Minute));
      Duration remaining = startTime.difference(DateTime.now());
      if (remaining.inMilliseconds > 0) {
        setState(() {
          days = remaining.inDays;
          hrs = remaining.inHours % 24;
          mins = remaining.inMinutes % 60;
          sec = remaining.inSeconds % 60;
          sum = days + hrs + mins + sec;
        });
      } else {
        t.cancel();
        setState(() {
          sum = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.light,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            new SliverList(
              delegate: new SliverChildBuilderDelegate(
                (context, index) => new ListTile(
                  title: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.black,
                          transform: Matrix4.translationValues(0.0, -4, 0.0),
                          padding: EdgeInsets.only(
                              left: 8, right: 12, top: 33, bottom: 12),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 11,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Next event: ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          _notes[index].event1Name,
                                          style: TextStyle(
                                              color: Colors.red[900],
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'COUNTDOWN ' +
                                          days.toString().padLeft(2, '0') +
                                          ':' +
                                          hrs.toString().padLeft(2, '0') +
                                          ':' +
                                          mins.toString().padLeft(2, '0') +
                                          ':' +
                                          sec.toString().padLeft(2, '0'),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(left: 4, right: 4),
                                  child: GestureDetector(
                                    onTap: () {
                                      launchURL(_notes[index].event2TicketLink);
                                    },
                                    child: Container(
                                      height: 43,
                                      decoration: new BoxDecoration(
                                        color: Colors.red[900],
                                        borderRadius: new BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          ),
                                          Text(
                                            'Buy Tickets',
                                            style: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchPage(),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            transform: Matrix4.translationValues(0.0, -4, 0.0),
                            child: (sum > 0)
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EventsDetailPage(
                                            event: int.parse(
                                                _notes[index].event1Id),
                                            past: 0,
                                            maxComp: int.parse(
                                                _notes[index].event1MaxComp),
                                            eventName: _notes[index].event1Name,
                                            eventPicture:
                                                _notes[index].event1Picture,
                                            eventDescription:
                                                _notes[index].event1Description,
                                            eventDate: _notes[index].event1Date,
                                            eventPlace:
                                                _notes[index].event1Place,
                                            eventLink:
                                                _notes[index].event1TicketLink,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 220,
                                      decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image: new NetworkImage(
                                                _notes[index].event1Picture),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              VideosLiveDetailPage(
                                            liveLink:
                                                _notes[index].event1LiveLink,
                                          ),
                                        ),
                                      );
                                    },
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Container(
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: Colors.grey.withOpacity(0.6),
                                          size: 100,
                                        ),
                                        decoration: BoxDecoration(
                                          image: new DecorationImage(
                                              image: new NetworkImage(
                                                  'https://img.youtube.com/vi/' +
                                                      _notes[index]
                                                          .event1LiveLink +
                                                      '/hqdefault.jpg'),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
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
                                  'Featured athletes: ',
                                  textAlign: TextAlign.left,
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
                childCount: _notes.length - onlyOne,
              ),
            ),
            new SliverList(
              delegate: new SliverChildBuilderDelegate(
                (context, index) => new ListTile(
                  title: new Card(
                    child: Container(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _notes.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AthletesDetailPage(
                                    athleteId:
                                        int.parse(_notes[index].athleteId),
                                    athleteFullName:
                                        _notes[index].athleteFullName,
                                    athleteWins:
                                        int.parse(_notes[index].athleteWins),
                                    athleteLosses:
                                        int.parse(_notes[index].athleteLosses),
                                    athleteDraws:
                                        int.parse(_notes[index].athleteDraws),
                                    athleteYellowcards: int.parse(
                                        _notes[index].totalYellowcards),
                                    athleteRedcards:
                                        int.parse(_notes[index].totalRedcards),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 120,
                              height: 120,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: new DecorationImage(
                                          image: new NetworkImage(
                                              _notes[index].athletePicture),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Text(_notes[index].athleteFullName),
                                  Text(_notes[index].athleteNickname),
                                ],
                              ),
                              margin: EdgeInsets.only(
                                  left: 5, right: 10, top: 3, bottom: 8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      margin: EdgeInsets.only(left: 8, right: 8),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
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
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 10000,
                                child: Text(
                                  'Following events: ',
                                  textAlign: TextAlign.left,
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
            new SliverList(
              delegate: new SliverChildBuilderDelegate(
                (context, index) => new ListTile(
                  title: new Card(
                    child: AspectRatio(
                      aspectRatio: 12 / 9,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _notes.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EventsDetailPage(
                                    event: int.parse(_notes[index].event2Id),
                                    past: 0,
                                    maxComp:
                                        int.parse(_notes[index].event2MaxComp),
                                    eventName: _notes[index].event2Name,
                                    eventPicture: _notes[index].event2Picture,
                                    eventDescription:
                                        _notes[index].event2Description,
                                    eventDate: _notes[index].event2Date,
                                    eventPlace: _notes[index].event2Place,
                                    eventLink: _notes[index].event2TicketLink,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image: new NetworkImage(
                                                _notes[index].event2Picture),
                                            fit: BoxFit.fill),
                                      ),
                                      margin:
                                          EdgeInsets.only(left: 8, right: 8),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.blueGrey[100],
                                    margin: EdgeInsets.only(left: 8, right: 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 7, left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(_notes[index].event2Name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(_notes[index].event2Date),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 4, right: 4),
                                            child: RaisedButton(
                                              onPressed: () {
                                                launchURL(_notes[index]
                                                    .event2TicketLink);
                                              },
                                              child: Text(
                                                'Buy Tickets',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              color: Colors.lightBlue[400],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.only(right: 8),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                ),
                childCount: 1,
              ),
            ),
            new SliverList(
              delegate: new SliverChildBuilderDelegate(
                (context, index) => new ListTile(
                  title: Row(
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
                ),
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
