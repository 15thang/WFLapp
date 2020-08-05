import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wfl_app/model/search.dart';
import 'athletePages/athlete_detail_page.dart';
import 'eventPages/event_detail_page.dart';
import 'eventPages/event_detail_page_past.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Search> _notes = List<Search>();
  List<Search> _notesForDisplay = List<Search>();

  Future<List<Search>> fetchNotes() async {
    var url = 'http://superfighter.nl/APP_output_search.php';
    var response = await http.get(url);

    var notes = List<Search>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Search.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        _notesForDisplay = _notes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : _listItem(index - 1);
          },
          itemCount: _notesForDisplay.length + 1,
        ));
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Search...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _notesForDisplay = _notes.where((note) {
              var noteTitle = note.noteTitle.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    if (_notesForDisplay[index].type == 'athlete') {
      return Card(
        child: Container(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 7.0, left: 16.0, right: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AthletesDetailPage(
                    athleteId: int.parse(_notesForDisplay[index].athleteId),
                    athleteFullName: _notesForDisplay[index].athleteFullName,
                    athleteWins: int.parse(_notesForDisplay[index].athleteWins),
                    athleteLosses:
                        int.parse(_notesForDisplay[index].athleteLosses),
                    athleteDraws:
                        int.parse(_notesForDisplay[index].athleteDraws),
                    athleteYellowcards:
                        int.parse(_notesForDisplay[index].totalYellowcards),
                    athleteRedcards:
                        int.parse(_notesForDisplay[index].totalRedcards),
                  ),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _notesForDisplay[index].athleteFullName,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _notesForDisplay[index].athleteNickname,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                Text('ATHLETE'),
              ],
            ),
          ),
        ),
      );
    } else if (_notesForDisplay[index].type == 'upcoming_event') {
      return Card(
        child: Container(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 7.0, left: 16.0, right: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventsDetailPage(
                    event: int.parse(_notesForDisplay[index].eventId),
                    past: 0,
                    maxComp: int.parse(_notesForDisplay[index].eventMaxComp),
                    eventName: _notesForDisplay[index].eventName,
                    eventPicture: _notesForDisplay[index].eventPicture,
                    eventDescription: _notesForDisplay[index].eventDescription,
                    eventDate: _notesForDisplay[index].eventDate,
                    eventPlace: _notesForDisplay[index].eventPlace,
                    eventLink: _notesForDisplay[index].eventTicketLink,
                  ),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _notesForDisplay[index].eventName,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _notesForDisplay[index].eventDate,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                Text('EVENT'),
              ],
            ),
          ),
        ),
      );
    } else if (_notesForDisplay[index].type == 'old_event') {
      return Card(
        child: Container(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 7.0, left: 16.0, right: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventsDetailPagePast(
                    event: int.parse(_notesForDisplay[index].eventId),
                    past: 1,
                    maxComp: int.parse(_notesForDisplay[index].eventMaxComp),
                    eventName: _notesForDisplay[index].eventName,
                    eventPicture: _notesForDisplay[index].eventPicture,
                    eventDescription: _notesForDisplay[index].eventDescription,
                    eventDate: _notesForDisplay[index].eventDate,
                    eventPlace: _notesForDisplay[index].eventPlace,
                  ),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _notesForDisplay[index].eventName,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _notesForDisplay[index].eventDate,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                Text('EVENT (over)'),
              ],
            ),
          ),
        ),
      );
    }
  }
}
