import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:wfl_app/Pages/eventPages/event_detail_page.dart';
import 'package:wfl_app/model/match_upcoming.dart';

class UpcomingMatchPage extends StatefulWidget {
  //Declare a field that holds the Athlete.
  final int athleteId;

  // In the constructor, require a Athlete.
  UpcomingMatchPage({Key key, @required this.athleteId}) : super(key: key);

  @override
  _UpcomingMatchPageState createState() => _UpcomingMatchPageState();
}

class _UpcomingMatchPageState extends State<UpcomingMatchPage> {
  List<MatchU> _notes = List<MatchU>();

  Future<List<MatchU>> fetchNotes() async {
    var url =
        'http://superfighter.nl/APP_output_match_upcoming.php?athlete_id=' +
            '${widget.athleteId}';

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
          if (index == 0) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.only(left: 3.0),
                        padding: const EdgeInsets.only(left: 5.0),
                        height: 20,
                        child: Text(
                          'Event',
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
                        height: 20,
                        color: Colors.grey[900],
                        child: Text(
                          'Date',
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
                        height: 20,
                        color: Colors.grey[900],
                        child: Text(
                          'Blok',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: const EdgeInsets.only(right: 5.0),
                        padding: const EdgeInsets.only(right: 5.0),
                        height: 20,
                        child: Text(
                          'Opponent',
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
                ),
              ],
            );
          } else {
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
                        flex: 4,
                        child: GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              ' ' + _notes[index].matchEventName,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventsDetailPage(
                                    event: int.parse(_notes[index].matchEvent),
                                    past: 0,
                                    maxComp: int.parse(_notes[index].eventMaxComp),
                                    eventName: _notes[index].matchEventName,
                                    eventPicture: _notes[index].eventPicture,
                                    eventDate: _notes[index].matchDate, 
                                    eventDescription: _notes[index].eventDescription,
                                    eventPlace: _notes[index].eventPlace,
                                    eventLink: _notes[index].eventLink
                                  ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          _notes[index].matchDate,
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Blok ' + _notes[index].matchBlok,
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                      ),
                      Expanded(
                        flex: 5,
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
          }
        },
        itemCount: _notes.length,
      ),
    );
  }
}
