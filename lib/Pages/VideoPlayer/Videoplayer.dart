import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;
  const VideoPlayerWidget({super.key, required this.videoPath});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late CachedVideoPlayerController videoPlayerController;
  bool isPlay = false;
  @override
  void initState() {
    super.initState();
    videoPlayerController =
        CachedVideoPlayerController.network(widget.videoPath)
          ..initialize().then((value) {
            videoPlayerController.setVolume(1);
            videoPlayerController.setLooping(true);
          });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 20,
      child: Stack(children: [
        CachedVideoPlayer(videoPlayerController),
        Align(
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () {
              if (isPlay) {
                videoPlayerController.pause();
              } else {
                videoPlayerController.play();
              }
              setState(() {
                isPlay = !isPlay;
              });
            },
            icon: Icon(isPlay ? Icons.pause_circle : Icons.play_arrow),
          ),
        )
      ]),
    );
  }
}