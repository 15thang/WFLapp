import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/athletes.dart';
import 'athlete_detail_page.dart';

class AthletesInfoPage extends StatefulWidget {
  const AthletesInfoPage({Key key}) : super(key: key);

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
    var url =
        'http://superfighter.nl/APP_output_athlete_info.php?athlete_id=296';
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
                                      _notes[index].athletePicture),
                                  fit: BoxFit.cover),
                            ),
                            child: Expanded(
                              child: Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Container(
                                  height: 7,
                                  color: Colors.red[900],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(_notes[index].athleteFullName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(_notes[index].athleteNationality,
                                  style: TextStyle(color: Colors.white)),
                              Text(_notes[index].athleteDayOfBirth,
                                  style: TextStyle(color: Colors.white)),
                              Text(athleteWeightclass + '" C',
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                    fontWeight: FontWeight.bold,
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
                                            child: Text('17',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                    fontWeight: FontWeight.bold,
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
                                            child: Text('8',
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
                                                    fontWeight: FontWeight.bold,
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
                                            child: Text('3',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                                    fontWeight: FontWeight.bold,
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
                                            child: Text('2',
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
                                child: Text('0',
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
        },
        itemCount: _notes.length,
      ),
    );
  }
}
