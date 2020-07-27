import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosDetailPage extends StatefulWidget {
  final int index;

  const VideosDetailPage({Key key, this.index}) : super(key: key);

  @override
  _VideosDetailPageState createState() => _VideosDetailPageState();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _VideosDetailPageState extends State<VideosDetailPage> {
  List<Video> _notes = List<Video>();

  YoutubePlayerController _controller;

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
        _controller = YoutubePlayerController(
          initialVideoId: _notes[widget.index].videoLink, // id youtube video
          flags: YoutubePlayerFlags(
            autoPlay: true,
            isLive: false,
            mute: false,
          ),
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
      ),
    );
  }
}
