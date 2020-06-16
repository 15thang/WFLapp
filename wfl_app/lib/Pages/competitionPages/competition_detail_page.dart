import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/athletecompetition.dart';
import 'package:wfl_app/model/athletes.dart';
import 'package:wfl_app/model/competition.dart';

class CompetitionDetailPage extends StatefulWidget {
  final int id;
  final String competitionName;

  // In the constructor, require a Event.
  CompetitionDetailPage({Key key, @required this.id, this.competitionName})
      : super(key: key);

  @override
  _CompetitionDetailPageState createState() => _CompetitionDetailPageState();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _CompetitionDetailPageState extends State<CompetitionDetailPage> {
  List<AthleteComp> _notes = List<AthleteComp>();

  Future<List<AthleteComp>> fetchNotes() async {
    var url =
        'http://superfighter.nl/APP_output_athletecompetition.php?competition_id=' +
            widget.id.toString();
    var response = await http.get(url);

    var notes = List<AthleteComp>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(AthleteComp.fromJson(noteJson));
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
      appBar: AppBar(
        title: Text(widget.competitionName),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[800],
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 3.0, top: 7),
                        padding: const EdgeInsets.only(left: 5.0),
                        height: 20,
                        child: Text(
                          'R',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            topLeft: Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.only(top: 7),
                        height: 20,
                        color: Colors.grey[900],
                        child: Text(
                          'Athlete',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.only(top: 7),
                        height: 20,
                        color: Colors.grey[900],
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'W / L / D',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.only(top: 7),
                        height: 20,
                        color: Colors.grey[900],
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'TKO / KO',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(top: 7),
                        padding: const EdgeInsets.only(left: 7),
                        height: 20,
                        color: Colors.grey[900],
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 10,
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(top: 7),
                        height: 20,
                        color: Colors.grey[900],
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 10,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.only(right: 5.0, top: 7),
                        padding: const EdgeInsets.only(right: 5.0),
                        height: 20,
                        child: Text(
                          'Points',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          } else if (index <= 4) {
            return new GestureDetector(
              onTap: () {},
              child: new Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(left: 5.0),
                            height: 40,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                index.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 40,
                            color: Colors.yellow[700],
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _notes[index].athleteFullName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 40,
                            color: Colors.grey[900],
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                _notes[index].athleteWins + ' / ' + _notes[index].athleteLosses + ' / ' + _notes[index].athleteDraws,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 40,
                            color: Colors.grey[900],
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                _notes[index].athleteTKO + ' / ' + _notes[index].athleteKO,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(left: 7),
                            height: 40,
                            color: Colors.grey[900],
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _notes[index].totalYellowcards,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(left: 7),
                            height: 40,
                            color: Colors.grey[900],
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _notes[index].totalRedcards,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.only(right: 5.0),
                            height: 40,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                _notes[index].totalPoints,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return new GestureDetector(
              onTap: () {},
              child: new Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(left: 5.0),
                            height: 40,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                index.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 40,
                            color: Colors.grey[900],
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _notes[index].athleteFullName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 40,
                            color: Colors.grey[900],
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                _notes[index].athleteWins + ' / ' + _notes[index].athleteLosses + ' / ' + _notes[index].athleteDraws,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 40,
                            color: Colors.grey[900],
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                _notes[index].athleteTKO + ' / ' + _notes[index].athleteKO,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(left: 7),
                            height: 40,
                            color: Colors.grey[900],
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _notes[index].totalYellowcards,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(left: 7),
                            height: 40,
                            color: Colors.grey[900],
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _notes[index].totalRedcards,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.only(right: 5.0),
                            height: 40,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                _notes[index].totalPoints,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ],
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
