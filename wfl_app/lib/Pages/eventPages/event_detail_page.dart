import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:wfl_app/model/event.dart';
import 'package:wfl_app/model/redbluecorner.dart';
import 'dart:math';

class EventsDetailPage extends StatefulWidget {
  //Declare a field that holds the Event.
  final Event event;

  // In the constructor, require a Event.
  EventsDetailPage({Key key, @required this.event}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventsDetailPage> {
  List<Corners> _notes = List<Corners>();

  Future<List<Corners>> fetchNotes() async {
    var url = 'http://superfighter.nl/APP_output_bluecorner.php?event_id=' +
        '${widget.event.eventId}';

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
    return new Scaffold(
      backgroundColor: Colors.grey[800],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 200.0,
            floating: false, //This is not needed since it's default
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('${widget.event.eventName}'),
              background: Image.network(
                '${widget.event.eventPicture}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, index) => new ListTile(
                title: new Card(
                  child: Container(
                    color: Colors.blueGrey[50],
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //redcorner
                        Container(
                          height: 220,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //red corner
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      topLeft: Radius.circular(5)),
                                  image: new DecorationImage(
                                      image: new NetworkImage(
                                          _notes[index].redcornerPicture),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              //red corner
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: 90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        //vs
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(' '),
                              Text('VS',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        //blue corner
                        Container(
                          height: 220,
                          width: 187.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              //blue corner
                              new Container(
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
                              //red corner
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: 90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
