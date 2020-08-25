import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:wfl_app/model/redbluecorner.dart';

class EventsDetailPageCompetition extends StatefulWidget {
  //Declare a field that holds the Event.
  final int event, past, maxComp, compId;
  final String eventName, eventPicture, eventDescription, eventDate, eventPlace, compName;

  // In the constructor, require a Event.
  EventsDetailPageCompetition(
      {Key key,
      @required this.event,
      this.past,
      this.compId,
      this.maxComp,
      this.compName,
      this.eventName,
      this.eventPicture,
      this.eventDescription,
      this.eventDate,
      this.eventPlace})
      : super(key: key);

  @override
  _EventPageCompetitionState createState() => _EventPageCompetitionState();
}

class _EventPageCompetitionState extends State<EventsDetailPageCompetition> {
  List<Corners> _notes = List<Corners>();

  Future<List<Corners>> fetchNotes() async {
    var url =
        'http://superfighter.nl/APP_output_bluecorner_competition.php?event_id=' +
            widget.event.toString() +
            '&competition_id=' +
            widget.compId.toString();

    var response = await http.get(url);

    var notes = List<Corners>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);

      for (var noteJson in notesJson) {
        notes.add(Corners.fromJson(noteJson));
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
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.black,
            title: Container(
              child: Column(
                children: <Widget>[
                  Text(widget.eventName),
                  Text('Competition: (' + widget.compName + ')'),
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, index) => new ListTile(
                title: new Card(
                  child: Container(
                    height: 240,
                    color: Colors.blueGrey[50],
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //redcorner
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    image: new DecorationImage(
                                        image: new NetworkImage(
                                            _notes[index].redcornerPicture),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 110,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(_notes[index].redcornerFullName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(_notes[index].redcornerNickname),
                                      Text(_notes[index].redcornerNationality),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //vs
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Text(' '),
                                Text(_notes[index].redcornerComp),
                                Text(' '),
                                Text(
                                  'VS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //blue corner
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //blue corner
                                Container(
                                  width: 130,
                                  height: 130,
                                  child: new Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(3.14159265359),
                                    child: Image(
                                        image: new NetworkImage(
                                            _notes[index].bluecornerPicture),
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
                                 Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 90,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(_notes[index].bluecornerFullName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(_notes[index].bluecornerNickname),
                                      Text(_notes[index].bluecornerNationality),
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
              ),
              childCount: _notes.length,
            ),
          ),
        ],
      ),
    );
  }
}
