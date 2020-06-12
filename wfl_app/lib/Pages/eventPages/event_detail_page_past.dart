import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:wfl_app/Pages/eventPages/event_competition_detail_page.dart';
import 'package:wfl_app/model/redbluecorner.dart';

class EventsDetailPagePast extends StatefulWidget {
  //Declare a field that holds the Event.
  final int event, past, maxComp;
  final String eventName, eventPicture, eventDescription, eventDate, eventPlace;

  // In the constructor, require a Event.
  EventsDetailPagePast(
      {Key key,
      @required this.event,
      this.past,
      this.maxComp,
      this.eventName,
      this.eventPicture,
      this.eventDescription,
      this.eventDate,
      this.eventPlace})
      : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventsDetailPagePast> {
  List<Corners> _notes = List<Corners>();

  Future<List<Corners>> fetchNotes() async {
    var url = 'http://superfighter.nl/APP_output_bluecorner.php?event_id=' +
        widget.event.toString();

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
    int event = widget.event, maxComp = widget.maxComp;
    String eventName = widget.eventName,
        eventPicture = widget.eventPicture,
        eventDescription = widget.eventDescription,
        eventDate = widget.eventDate,
        eventPlace = widget.eventPlace;
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
            backgroundColor: Colors.black,
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.eventName),
              background: Image.network(
                widget.eventPicture,
                fit: BoxFit.cover,
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, index) => new ListTile(
                title: new Card(
                  child: Container(
                    color: Colors.grey[500],
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 7, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.eventName + ' (Ended)',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(widget.eventDescription),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          widget.eventDate +
                                              ' ' +
                                              widget.eventPlace,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
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
              childCount: 1,
            ),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, index) => new ListTile(
                title: new Card(
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        border:
                            Border.all(width: 1.0, color: Colors.grey[800])),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return new GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EventsDetailPageCompetition(
                                  event: widget.event,
                                  past: 0,
                                  maxComp: widget.maxComp,
                                  compId:
                                      int.parse(_notes[index].bluecornerCompId),
                                  compName: _notes[index].bluecornerCompName,
                                  eventName: widget.eventName,
                                  eventPicture: widget.eventPicture,
                                  eventDescription: widget.eventDescription,
                                  eventDate: widget.eventDate,
                                  eventPlace: widget.eventPlace,
                                ),
                              ),
                            );
                          },
                          child: new Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 10),
                            width: 150,
                            color: Colors.grey[900],
                            child: Expanded(
                              flex: 1,
                              child: Text(
                                _notes[index].bluecornerCompName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: widget.maxComp,
                    ),
                  ),
                ),
              ),
              childCount: 1,
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 130,
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
                                  height: 90,
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
                            width: 111.4,
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
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //blue corner
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      width: 130,
                                      height: 130,
                                      child: new Transform(
                                        alignment: Alignment.center,
                                        transform:
                                            Matrix4.rotationY(3.14159265359),
                                        child: Image(
                                            image: new NetworkImage(
                                                _notes[index]
                                                    .bluecornerPicture),
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
                                  ],
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
