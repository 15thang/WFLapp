import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wfl_app/model/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosLiveDetailPage extends StatefulWidget {
  final String liveLink;

  const VideosLiveDetailPage({Key key, this.liveLink}) : super(key: key);

  @override
  _VideosLiveDetailPageState createState() => _VideosLiveDetailPageState();
}

//Future is to launch URL buttons (like buy ticket)
Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, forceSafariVC: true);
  } else {
    print("Can't Launch");
  }
}

class _VideosLiveDetailPageState extends State<VideosLiveDetailPage> {
  YoutubePlayerController _controller;

  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, forceSafariVC: true);
    } else {
      print("Can't Launch");
    }
  }

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.liveLink, // id youtube video
      flags: YoutubePlayerFlags(
        autoPlay: true,
        isLive: true,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: <Widget>[
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
          ),
          FloatingActionButton(
            child: Icon(
              Icons.clear,
            ),
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
