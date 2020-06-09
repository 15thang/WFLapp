import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:wfl_app/model/athletes.dart';
import 'package:wfl_app/model/match_upcoming.dart';

class UpcomingMatchPage extends StatefulWidget {
  //Declare a field that holds the Athlete.
  final Athlete athlete;

  // In the constructor, require a Athlete.
  UpcomingMatchPage({Key key, @required this.athlete}) : super(key: key);

  @override
  _UpcomingMatchPageState createState() => _UpcomingMatchPageState();
}

class _UpcomingMatchPageState extends State<UpcomingMatchPage> {
  List<MatchU> _notes = List<MatchU>();

  Future<List<MatchU>> fetchNotes() async {
    var url =
        'http://superfighter.nl/APP_output_match_upcoming.php?athlete_id=' +
            '${widget.athlete.athleteId}';

    var response = await http.get(url);

    var notes = List<MatchU>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);

      for (var noteJson in notesJson) {
        notes.add(MatchU.fromJson(noteJson));
      }
    }
    return notes;
  }

  final GlobalKey _cardKey = GlobalKey();
  Size cardSize;
  Offset cardPosition;

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getSizeAndPosition());
  }

  getSizeAndPosition() {
    RenderBox _cardBox = _cardKey.currentContext.findRenderObject();
    cardSize = _cardBox.size;
    cardPosition = _cardBox.localToGlobal(Offset.zero);
    print(cardSize);
    print(cardPosition);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {},
            child: new Card(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        ' ' + _notes[index].matchEvent,
                        style: TextStyle(color: Colors.grey[900]),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        _notes[index].matchDate,
                        style: TextStyle(color: Colors.grey[900]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        _notes[index].matchBlok,
                        style: TextStyle(color: Colors.grey[900]),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        _notes[index].matchOpponent,
                        style: TextStyle(color: Colors.grey[900]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: _notes.length,
      ),
    );
  }
}
