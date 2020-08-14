import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/athletes.dart';

class AthletesInfoPage extends StatefulWidget {
  final int athleteID;

  const AthletesInfoPage({Key key, @required this.athleteID}) : super(key: key);

  @override
  _AthletesInfoPage createState() => _AthletesInfoPage();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _AthletesInfoPage extends State<AthletesInfoPage> {
  List<Athlete> _notes = List<Athlete>();

  Future<List<Athlete>> fetchNotes() async {
    var url = 'http://superfighter.nl/APP_output_athlete_info.php?athlete_id=' +
        widget.athleteID.toString();
    var response = await http.get(url);

    var notes = List<Athlete>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Athlete.fromJson(noteJson));
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
          String athleteWeightclass = _notes[index].athleteWeightclass;
          switch (athleteWeightclass) {
            case "0":
              athleteWeightclass = "";
              break;
            case "1":
              athleteWeightclass = "95+";
              break;
            case "2":
              athleteWeightclass = "95";
              break;
            case "3":
              athleteWeightclass = "84";
              break;
            case "4":
              athleteWeightclass = "77";
              break;
            case "5":
              athleteWeightclass = "70";
              break;
            case "6":
              athleteWeightclass = "65";
              break;
            case "7":
              athleteWeightclass = "61";
              break;
            case "8":
              athleteWeightclass = "56";
              break;
            case "9":
              athleteWeightclass = "52";
              break;
            case "10":
              athleteWeightclass = "48";
              break;
            case "11":
              athleteWeightclass = "44";
              break;
            case "12":
              athleteWeightclass = "40";
              break;
            case "13":
              athleteWeightclass = "36";
              break;
            case "14":
              athleteWeightclass = "32";
              break;
          }
          //switch case om de nummers naar letters te veranderen
          String athleteGrade = _notes[index].athleteGrade;
          switch (athleteGrade) {
            case "0":
              athleteGrade = "";
              break;
            case "1":
              athleteGrade = "A";
              break;
            case "2":
              athleteGrade = "B";
              break;
            case "3":
              athleteGrade = "C";
              break;
            case "4":
              athleteGrade = "N";
              break;
            case "5":
              athleteGrade = "J";
              break;
          }
          //Als ster 1 is, wordt het een ster
          String athleteStar = _notes[index].athleteStar.toString();
          if (athleteStar == "1") {
            athleteStar = "★";
          }
          if (index == 0) {
            return new GestureDetector(
              child: new Card(
                color: Colors.grey[900],
                elevation: 5,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey[900],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                image: new DecorationImage(
                                    image: new NetworkImage(
                                        _notes[index].athleteProfilePicture),
                                    fit: BoxFit.cover),
                              ),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text(athleteStar,
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.yellow[700],
                                          shadows: <Shadow>[
                                            Shadow(
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 3.0,
                                                color: Colors.black),
                                          ],
                                        )),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5.0),
                                      child: Text(_notes[index].athleteStars,
                                          style: TextStyle(fontSize: 17)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  _notes[index].athleteTitle,
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      backgroundColor: Colors.red[900]),
                                ),
                                Text(_notes[index].athleteFullName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Text(_notes[index].athleteNationality,
                                    style: TextStyle(color: Colors.white)),
                                Text(_notes[index].athleteDayOfBirth,
                                    style: TextStyle(color: Colors.white)),
                                Text(athleteWeightclass + 'kg ' + athleteGrade,
                                    style: TextStyle(color: Colors.white)),
                                Container(
                                  margin: const EdgeInsets.only(top: 5.0),
                                  child: Text(_notes[index].athleteDescription,
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10.0, bottom: 5.0),
                                  child: Text('STATS',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: 1000,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                    width: 1,
                                                  ),
                                                  bottom: BorderSide(
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: Text('WINS',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                            Container(
                                              width: 1000,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[600],
                                                border: Border(
                                                  right: BorderSide(
                                                    width: 1,
                                                  ),
                                                  bottom: BorderSide(
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                  _notes[index]
                                                      .athleteWins
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 22)),
                                            ),
                                            Container(
                                              width: 1000,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                    width: 1,
                                                  ),
                                                  bottom: BorderSide(
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: Text('TKO',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                            Container(
                                              width: 1000,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[600],
                                                border: Border(
                                                  right: BorderSide(
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                  _notes[index]
                                                      .athleteTKO
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: 1000,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    width: 1,
                                                  ),
                                                  bottom: BorderSide(
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: Text('LOSSES',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                            Container(
                                              width: 1000,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[600],
                                                border: Border(
                                                  left: BorderSide(
                                                    width: 1,
                                                  ),
                                                  bottom: BorderSide(
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                  _notes[index]
                                                      .athleteLosses
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 22)),
                                            ),
                                            Container(
                                              width: 1000,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    width: 1,
                                                  ),
                                                  bottom: BorderSide(
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: Text('KO',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                            Container(
                                              width: 1000,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[600],
                                                border: Border(
                                                  left: BorderSide(
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                  _notes[index]
                                                      .athleteKO
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1000,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        width: 2,
                                      ),
                                      right: BorderSide(
                                        width: 2,
                                      ),
                                      bottom: BorderSide(
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: Text('DRAW',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                                Container(
                                  width: 1000,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    border: Border(
                                      left: BorderSide(
                                        width: 2,
                                      ),
                                      right: BorderSide(
                                        width: 2,
                                      ),
                                      bottom: BorderSide(
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                      _notes[index].athleteDraws.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return new GestureDetector(
              child: new Card(
                color: Colors.grey[900],
                elevation: 5,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 7),
                      child: Text(athleteStar,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.yellow[700],
                            shadows: <Shadow>[
                              Shadow(
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 3.0,
                                  color: Colors.black),
                            ],
                          )),
                    ),
                    Container(
                      child: Text(
                        _notes[index].athleteLastTitle,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                                offset: Offset(0.0, 0.0),
                                blurRadius: 3.0,
                                color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        itemCount: _notes.length,
      ),
    );
  }
}
