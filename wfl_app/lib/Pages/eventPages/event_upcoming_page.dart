import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/event.dart';

import 'event_detail_page.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({Key key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _EventPageState extends State<UpcomingEvents> {
  static String routeName;

  List<Event> _notes = List<Event>();

  Future<List<Event>> fetchNotes() async {
    var url = 'http://superfighter.nl/APP_output_event.php';
    var response = await http.get(url);

    var notes = List<Event>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Event.fromJson(noteJson));
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventsDetailPage(
                    event: int.parse(_notes[index].eventId),
                    eventName: _notes[index].eventName,
                    eventPicture: _notes[index].eventPicture,
                  ),
                ),
              );
            },
            child: new Card(
              color: Colors.blueGrey[100],
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 220,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  image: new DecorationImage(
                                      image: new NetworkImage(
                                          _notes[index].eventPicture),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(top: 7, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(_notes[index].eventName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(_notes[index].eventDate),
                                      Text(_notes[index].eventPlace),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 6.0),
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RaisedButton(
                                        onPressed: () {
                                          launchURL(
                                              _notes[index].eventTicketLink);
                                        },
                                        child: Text(
                                          'Buy Tickets',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        color: Colors.lightBlue[400],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: _notes.length,
      ),
    );
  }
}
