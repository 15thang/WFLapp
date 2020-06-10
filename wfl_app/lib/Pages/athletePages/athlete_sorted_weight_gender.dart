import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/athletes.dart';
import 'athlete_detail_page.dart';

class AthleteWeightGender extends StatefulWidget {
  final int weight, grade, gender;

  const AthleteWeightGender({Key key, @required this.weight, this.gender, this.grade}) : super(key: key);

  @override
  _AthleteWeightGender createState() => _AthleteWeightGender();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _AthleteWeightGender extends State<AthleteWeightGender> {
  List<Athlete> _notes = List<Athlete>();

  Future<List<Athlete>> fetchNotes() async {
    var url =
        'http://superfighter.nl/APP_output_athlete_sort_weight_gender.php?weight=' +
            widget.weight.toString() + '&gender=' + widget.gender.toString() + '&grade=' + widget.grade.toString();
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
          return new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AthletesDetailPage(athlete: _notes[index]),
                ),
              );
            },
            child: new Card(
              color: Colors.grey[400],
              elevation: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 174,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            topLeft: Radius.circular(5)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: 174,
                                  height: 174,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        topLeft: Radius.circular(5)),
                                    image: new DecorationImage(
                                        image: new NetworkImage(_notes[index]
                                            .athleteProfilePicture),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    gradient: LinearGradient(
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [
                                        Colors.grey.withOpacity(0.0),
                                        Colors.black.withOpacity(0.5)
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 174,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(_notes[index].athleteFullName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  Text(_notes[index].athleteNickname,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 18)),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(_notes[index].athleteNationality,
                                            style: TextStyle(fontSize: 17)),
                                        Text(_notes[index].athleteDayOfBirth,
                                            style: TextStyle(fontSize: 17)),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                              athleteWeightclass +
                                                  '"  ' +
                                                  athleteGrade,
                                              style: TextStyle(fontSize: 17)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
