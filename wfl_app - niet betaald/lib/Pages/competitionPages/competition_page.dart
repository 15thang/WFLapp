import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/paidapplink.dart';

class CompetitionPage extends StatefulWidget {
  const CompetitionPage({Key key}) : super(key: key);

  @override
  _CompetitionPage createState() => _CompetitionPage();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _CompetitionPage extends State<CompetitionPage> {
  List<Store> _notes = List<Store>();

  int onlyOne = 30;

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, forceSafariVC: true);
    } else {
      print("Can't Launch");
    }
  }

  Future<List<Store>> fetchNotes() async {
    var url = 'http://superfighter.nl/paidapplink_output.php';
    var response = await http.get(url);
    var notes = List<Store>();
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Store.fromJson(noteJson));
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
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
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
          new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, index) => new ListTile(
                title: Container(
                  child: Column(
                    children: <Widget>[
                      AspectRatio(aspectRatio: 11 / 5),
                      Text('Premium only'),
                      RaisedButton(
                        onPressed: () {
                          launchURL(_notes[index].link);
                        },
                        child: Text(
                          'Get WFL-PREMIUM',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.lightBlue[400],
                      ),
                    ],
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
