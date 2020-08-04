import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wfl_app/model/athletes.dart';
import 'package:http/http.dart' as http;

import 'athletePages/athlete_detail_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Athlete> _notes = List<Athlete>();
  List<Athlete> _notesForDisplay = List<Athlete>();

  Future<List<Athlete>> fetchNotes() async {
    var url = 'http://superfighter.nl/APP_output_athlete.php';
    var response = await http.get(url);

    var notes = List<Athlete>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Athlete.fromJson(noteJson));
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
              var noteTitle = note.athleteFullName.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    if (int.parse(_notesForDisplay[index].athleteId) > 284) {
      return Card(
        child: Container(
          color: Colors.green,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _notesForDisplay[index].athleteFullName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  _notesForDisplay[index].athleteNickname,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                Text(
                  _notesForDisplay[index].athleteId,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Card(
        child: Container(
          color: Colors.blue,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _notesForDisplay[index].athleteFullName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  _notesForDisplay[index].athleteNickname,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                Text(
                  _notesForDisplay[index].athleteId,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
