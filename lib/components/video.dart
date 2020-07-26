import 'dart:async';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:hackathon_media_player/components/videoMetaData.dart';

class Video extends StatefulWidget {
  final String url;
  final int postkey;
  final bool shouldPlay;
  final Function unmutePlayer;
  final Function mutePlayer;
  final CachedVideoPlayerController mainController;

  Video(
      {this.url,
      this.postkey,
      this.shouldPlay,
      this.unmutePlayer,
      this.mainController,
      this.mutePlayer});

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  CachedVideoPlayerController _controller;
  Duration _position;
  bool muted = true;
  int seconds = 0;
  bool playing = false;

  @override
  void initState() {
    super.initState();

    _controller = widget.mainController
      ..addListener(() {
        Timer.run(() {
          this.setState(() {
            _position = _controller.value.position;
          });
        });
      })
      ..initialize().then((_) {
        _controller.setVolume(0);
        _controller.setLooping(true);
        _controller.pause();
      });
  }

  videoVolume() {
    if (muted) {
      widget.unmutePlayer();
      setState(() {
        muted = !muted;
      });
    } else {
      widget.mutePlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: new Key(widget.postkey.toString()),
        onVisibilityChanged: (info) {
          if (info.visibleFraction == 1) {
            HapticFeedback.vibrate();
            _controller.play();
          } else {
            _controller.pause();
          }
        },
        child: GestureDetector(
          onTap: videoVolume,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 450),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                children: [
                  Container(
                    child: Center(
                      child: _controller.value.initialized
                          ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: CachedVideoPlayer(_controller),
                            )
                          : CircularProgressIndicator(),
                    ),
                  ),
                  VideoMetaData(position: _position, muted: muted)
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
