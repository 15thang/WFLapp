import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/Pages/videoPages/video_detail_page.dart';
import 'package:wfl_app/model/video.dart';

class Videos extends StatefulWidget {
  const Videos({Key key}) : super(key: key);

  @override
  _VideosState createState() => _VideosState();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _VideosState extends State<Videos> {
  List<Video> _notes = List<Video>();

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, forceSafariVC: true);
    } else {
      print("Can't Launch");
    }
  }

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
        title: Row(
        children: <Widget>[
          Container(
            height:90,
            width: 90,
            decoration: BoxDecoration(
              image: new DecorationImage(
                  image: new NetworkImage(
                      'http://superfighter.nl/pics/wflicon.jpg'),
                  fit: BoxFit.fill),
            ),
          ),
          Text(' Videos',
              style: TextStyle(color: Colors.white),
            ),
        ],
      ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[800],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {},
            child: new Card(
              color: Colors.red[900],
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideosDetailPage(
                                  link: _notes[index].videoLink,
                                ),
                              ),
                            );
                          },
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.grey.withOpacity(0.6),
                                size: 100,
                              ),
                              decoration: BoxDecoration(
                                image: new DecorationImage(
                                    image: new NetworkImage(
                                        'https://img.youtube.com/vi/' +
                                            _notes[index].videoLink +
                                            '/hqdefault.jpg'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1000,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.red.withOpacity(0.5)
                              ],
                              stops: [0.0, 1.0],
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            _notes[index].videoTitle,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[200],
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: _notes.length,
      ),
    );
  }
}
