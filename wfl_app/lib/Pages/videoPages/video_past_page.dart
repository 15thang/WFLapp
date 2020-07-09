import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/event.dart';

class PastVideos extends StatefulWidget {
  const PastVideos({Key key}) : super(key: key);

  @override
  _PastVideosState createState() => _PastVideosState();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _PastVideosState extends State<PastVideos> {
  List<Event> _notes = List<Event>();

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, forceSafariVC: true);
    } else {
      print("Can't Launch");
    }
  }

  Future<List<Event>> fetchNotes() async {
    var url = 'http://superfighter.nl/APP_output_videos.php';
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
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoDetailPagePast(
                    event: int.parse(_notes[index].eventId),
                    past: 1,
                    maxComp: int.parse(_notes[index].eventMaxComp),
                    eventName: _notes[index].eventName,
                    eventPicture: _notes[index].eventPicture,
                    eventDescription: _notes[index].eventDescription, 
                    eventDate: _notes[index].eventDate, 
                    eventPlace: _notes[index].eventPlace,
                  ),
                ),
              );*/
            },
            child: new Card(
              color: Colors.grey,
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 195,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                image: new DecorationImage(
                                    image: new NetworkImage(
                                        _notes[index].eventPicture),
                                    fit: BoxFit.cover))),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 400,
                    /*decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(5)),
                      image: new DecorationImage(
                          image: new NetworkImage(_notes[index].eventPicture),
                          fit: BoxFit.fill,)
                          ),*/
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 250,
                            padding: const EdgeInsets.only(top: 7, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(_notes[index].eventName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(_notes[index].eventDate),
                                Text(_notes[index].eventPlace),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )),
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
