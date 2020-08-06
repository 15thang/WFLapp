import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/Pages/videoPages/video_detail_page.dart';
import 'package:wfl_app/model/athletes.dart';
import 'package:wfl_app/model/video.dart';

class Videos extends StatefulWidget {
  const Videos({Key key}) : super(key: key);

  @override
  _Videos createState() => _Videos();
}

class _Videos extends State<Videos> {
  List<Video> _notes = List<Video>();

  Future<List<Video>> fetchNotes() async {
    var url = 'http://superfighter.nl/APP_output_videos.php';
    var response = await http.get(url);

    var notes = List<Video>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Video.fromJson(noteJson));
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
              '  Videos',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[800],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideosDetailPage(
                    index: index,
                  ),
                ),
              );
            },
            child: new Card(
              color: Colors.blueGrey[100],
              elevation: 5,
              child: Container(
                child: Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          image: new DecorationImage(
                              image: new NetworkImage(
                                  'https://img.youtube.com/vi/' +
                                      _notes[index].videoLink +
                                      '/hqdefault.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(_notes[index].videoTitle),
                    )
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
