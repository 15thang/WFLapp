import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
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
  List<Athlete> _notes = List<Athlete>();

  Future<List<Athlete>> fetchNotes() async {
    var url =
        'http://superfighter.nl/APP_output_athletecompetition.php?competition_id=' +
            widget.id.toString();
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
      appBar: AppBar(
        title: Text(widget.competitionName),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[800],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {},
            child: new Card(
                child: Column(
              children: <Widget>[
                Container(
                  child: Text(_notes[index].athleteFullName),
                ),
              ],
            )),
          );
        },
        itemCount: _notes.length,
      ),
    );
  }
}
