import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/competition.dart';

import 'competition_detail_page.dart';

class Competition extends StatefulWidget {
  const Competition({Key key}) : super(key: key);

  @override
  _CompetitionPageState createState() => _CompetitionPageState();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _CompetitionPageState extends State<Competition> {
  List<Competitions> _notes = List<Competitions>();

  Future<List<Competitions>> fetchNotes() async {
    var url = 'http://superfighter.nl/APP_output_competition.php';
    var response = await http.get(url);

    var notes = List<Competitions>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Competitions.fromJson(noteJson));
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
        title: const Text('Competitions'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[800],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompetitionDetailPage(
                    id: int.parse(_notes[index].competitionId),
                    competitionName: _notes[index].competitionName,
                  ),
                ),
              );
            },
            child: new Card(
                child: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  color: Colors.grey[900],
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _notes[index].competitionName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
