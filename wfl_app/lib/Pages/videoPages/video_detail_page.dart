import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class VideosDetailPage extends StatefulWidget {
  final String link;

  const VideosDetailPage({Key key, this.link}) : super(key: key);

  @override
  _VideosDetailPageState createState() => _VideosDetailPageState();
}

class _VideosDetailPageState extends State<VideosDetailPage> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    setState(() {
      _controller = YoutubePlayerController(
        initialVideoId: widget.link, // id youtube video
        flags: YoutubePlayerFlags(
          autoPlay: true,
          isLive: false,
          mute: false,
        ),
      );
    });
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
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
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
