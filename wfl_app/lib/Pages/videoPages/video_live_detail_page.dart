import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosLiveDetailPage extends StatefulWidget {
  final String liveLink;

  const VideosLiveDetailPage({Key key, this.liveLink}) : super(key: key);

  @override
  _VideosLiveDetailPageState createState() => _VideosLiveDetailPageState();
}

class _VideosLiveDetailPageState extends State<VideosLiveDetailPage> {
  YoutubePlayerController _controller;

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
