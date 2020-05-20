import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../model/video.dart';

class VideoDetailPage extends StatelessWidget {
  // Declare a field that holds the Video.
  final Video video;

  // In the constructor, require a Video.
  VideoDetailPage({Key key, @required this.video, Video videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < videoList2.length; i++) {
    YoutubePlayerController _controller = YoutubePlayerController(
        initialVideoId: videoList2[i].id,
        flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
        ),
    );
    
    return 
    YoutubePlayer(
      controller: _controller,
      liveUIColor: Colors.amber,
    );
    }
}
}