import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoComponent extends StatefulWidget {
  final String src;
  const VideoComponent({super.key, required this.src});

  @override
  State<VideoComponent> createState() => VideoComponentState();
}

class VideoComponentState extends State<VideoComponent> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.src)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.setLooping(true);
        setState(() {
          _controller.play();
        });
      });
  }

  void stop() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }
}
