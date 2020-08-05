import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/competition.dart';

class CompetitionPage extends StatefulWidget {
  const CompetitionPage({Key key}) : super(key: key);

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

class _CompetitionPageState extends State<CompetitionPage> {
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
        title: Row(
          children: <Widget>[
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(
                        'http://superfighter.nl/pics/wflicon.jpg'),
                    fit: BoxFit.fill),
              ),
            ),
            Text(
              ' Competitions',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Text(
          'Premium only',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
