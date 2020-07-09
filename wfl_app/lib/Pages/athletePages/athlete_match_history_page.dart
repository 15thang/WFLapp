import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:wfl_app/model/athletes.dart';
import 'package:wfl_app/model/match_history.dart';

class MatchHistoryPage extends StatefulWidget {
  //Declare a field that holds the Athlete.
  final int athleteId,
      athleteWins,
      athleteLosses,
      athleteDraws,
      athleteYellowcards,
      athleteRedcards;

  // In the constructor, require a Athlete.
  MatchHistoryPage(
      {Key key,
      @required this.athleteId,
      this.athleteWins,
      this.athleteLosses,
      this.athleteDraws,
      this.athleteYellowcards,
      this.athleteRedcards})
      : super(key: key);

  @override
  _MatchHistoryPageState createState() => _MatchHistoryPageState();
}

class _MatchHistoryPageState extends State<MatchHistoryPage> {
  List<MatchH> _notes = List<MatchH>();

  Future<List<MatchH>> fetchNotes() async {
    var url =
        'http://superfighter.nl/APP_output_match_history.php?athlete_id=' +
            '${widget.athleteId}';

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
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.only(left: 3.0, bottom: 5.0),
                        padding: const EdgeInsets.only(left: 5.0),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'W/L/D: ${widget.athleteWins}/${widget.athleteLosses}/${widget.athleteDraws}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.only(left: 3.0, bottom: 5.0),
                        padding: const EdgeInsets.only(left: 5.0),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Total points: 9',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 3.0, bottom: 5.0, right: 3.0),
                        padding: const EdgeInsets.only(left: 5.0),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '${widget.athleteYellowcards} ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    color: Colors.yellow,
                                    margin: const EdgeInsets.only(right: 15.0),
                                  ),
                                  Text(
                                    '${widget.athleteRedcards} ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 3.0),
                        padding: const EdgeInsets.only(left: 5.0),
                        height: 20,
                        child: Text(
                          'Date',
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
                      flex: 1,
                      child: Container(
                        height: 20,
                        color: Colors.grey[900],
                        child: Text(
                          'Result',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 20,
                        color: Colors.grey[900],
                        child: Text(
                          'Opponent',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 20,
                        color: Colors.grey[900],
                        child: Text(
                          'Method',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 5.0),
                        padding: const EdgeInsets.only(right: 5.0),
                        height: 20,
                        child: Text(
                          'Round',
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
                        flex: 1,
                        child: Text(
                          ' ' + _notes[index].matchDate,
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          _notes[index].matchResult,
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
                      Expanded(
                        flex: 1,
                        child: Text(
                          _notes[index].matchMethod,
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          _notes[index].matchRound,
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
