import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:wfl_app/model/athletes.dart';
import 'package:wfl_app/model/match_history.dart';

class MatchHistoryPage extends StatefulWidget {
  //Declare a field that holds the Athlete.
  final Athlete athlete;

  // In the constructor, require a Athlete.
  MatchHistoryPage({Key key, @required this.athlete}) : super(key: key);

  @override
  _MatchHistoryPageState createState() => _MatchHistoryPageState();
}

class _MatchHistoryPageState extends State<MatchHistoryPage> {
  List<MatchH> _notes = List<MatchH>();

  Future<List<MatchH>> fetchNotes() async {
    var url =
        'http://superfighter.nl/APP_output_match_history.php?athlete_id=' +
            '${widget.athlete.athleteId}';

    var response = await http.get(url);

    var notes = List<MatchH>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);

      for (var noteJson in notesJson) {
        notes.add(MatchH.fromJson(noteJson));
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
    return new Scaffold(
      key: _cardKey,
      backgroundColor: Colors.grey[800],
      body: CustomScrollView(
        slivers: <Widget>[
          new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, index) => new ListTile(
                title: new Card(
                  child: Container(
                    color: Colors.blueGrey[50],
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(_notes[index].matchDate),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(_notes[index].matchResult),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(_notes[index].matchOpponent),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(_notes[index].matchMethod),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(_notes[index].matchRound),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              childCount: _notes.length,
            ),
          ),
        ],
      ),
    );
  }
}
