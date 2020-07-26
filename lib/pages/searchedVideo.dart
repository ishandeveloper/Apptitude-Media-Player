import 'dart:async';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_media_player/components/rectangularThumb.dart';
import 'package:marquee/marquee.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SearchedVideo extends StatefulWidget {
  final String url;

  SearchedVideo({this.url});

  @override
  _SearchedVideoState createState() => _SearchedVideoState();
}

class _SearchedVideoState extends State<SearchedVideo> {
  Duration _position;

  bool muted = false;

  CachedVideoPlayerController _controller;

  @override
  void initState() {
    _controller = CachedVideoPlayerController.network(widget.url)
      ..addListener(() {
        Timer.run(() {
          this.setState(() {
            _position = _controller.value.position;
          });
        });
      })
      ..initialize().then((_) {
        _controller.setVolume(100);
        _controller.setLooping(true);
        _controller.play();
      });

    super.initState();
  }

  videoVolume() {
    if (muted) {
      _controller.setVolume(100);
    } else {
      _controller.setVolume(0);
    }
    setState(() {
      muted = !muted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1F2128),
        body: Container(
          child: SafeArea(
            child: Column(
              children: [
                GestureDetector(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.4),
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        children: [
                          Container(
                            child: Center(
                              child: _controller.value.initialized
                                  ? AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: Hero(
                                          tag: widget.url,
                                          transitionOnUserGestures: true,
                                          child:
                                              CachedVideoPlayer(_controller)),
                                    )
                                  : CircularProgressIndicator(),
                            ),
                          ),
                          GestureDetector(
                            onVerticalDragUpdate: (details) {
                              if (details.delta.direction > 1 &&
                                  details.delta.distance > 10) {
                                Navigator.pop(context);
                              }
                            },
                            child: RotatedBox(
                                quarterTurns: 3,
                                child: IconButton(
                                    icon: Icon(Icons.arrow_back_ios,
                                        color: Colors.white),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                (_position?.inSeconds != null &&
                        _controller?.value?.position != Duration())
                    ? LinearProgressIndicator(
                        value: _position.inSeconds /
                            _controller?.value?.duration?.inSeconds,
                        valueColor: AlwaysStoppedAnimation(Color(0xff553DE8)),
                        backgroundColor: Colors.white,
                        // minHeight: 5,
                      )
                    : LinearProgressIndicator(
                        // value: 0,
                        valueColor: AlwaysStoppedAnimation(Color(0xff553DE8)),
                        backgroundColor: Colors.white,
                        // minHeight: 5,
                      ),
                VideoInfo(widget: widget),
                Spacer(),
                VideoControls(controller: _controller, position: _position)
              ],
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

class VideoInfo extends StatelessWidget {
  const VideoInfo({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final SearchedVideo widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Playing",
              style:
                  GoogleFonts.poppins(color: Color(0xffaaaaaa), fontSize: 16),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Marquee(
                text: "${widget.url.split('/').last}",
                scrollAxis: Axis.horizontal,
                fadingEdgeStartFraction: 0.1,
                fadingEdgeEndFraction: 0.1,
                pauseAfterRound: Duration(seconds: 3),
                showFadingOnlyWhenScrolling: true,
                blankSpace: 50,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 2.5),
            Text(
              "from : ${widget.url.split('//').last.split('/').first}",
              style:
                  GoogleFonts.poppins(color: Color(0xffaaaaaa), fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}

class VideoControls extends StatelessWidget {
  const VideoControls({
    Key key,
    @required CachedVideoPlayerController controller,
    @required Duration position,
  })  : _controller = controller,
        _position = position,
        super(key: key);

  final CachedVideoPlayerController _controller;
  final Duration _position;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Color(0xff000000),
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: IconButton(
                      icon: Icon(Icons.fast_rewind, color: Colors.white),
                      iconSize: 30,
                      onPressed: () {
                        _controller.seekTo(Duration(seconds: 0));
                      }),
                ),
              ),
              SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                      spinnerMode: false,
                      size: 128,
                      customColors: CustomSliderColors(
                          trackColor: Color(0xffaaaaaa),
                          progressBarColor: Color(0xff553DE8)),
                      customWidths: CustomSliderWidths(
                          progressBarWidth: 2,
                          trackWidth: 1,
                          shadowWidth: 0,
                          handlerSize: 0)),
                  min: 0,
                  initialValue: _controller.value.position.inSeconds.toDouble(),
                  max: _controller.value.duration.inSeconds.toDouble(),
                  innerWidget: (val) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
                      height: 128,
                      width: 128,
                      decoration: BoxDecoration(
                          color: Color(0xff553DE8),
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                          icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white),
                          iconSize: 38,
                          onPressed: () {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          }),
                    );
                  }),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Color(0xff000000),
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                    icon: Icon(Icons.fast_forward, color: Colors.white),
                    iconSize: 36,
                    onPressed: () {
                      _controller
                          .seekTo(Duration(seconds: _position.inSeconds + 5));
                    }),
              ),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.volume_down,
                  color: Colors.white,
                ),
                Expanded(
                  child: SliderTheme(
                      data: SliderThemeData(
                          thumbShape: CustomSliderThumbRect(
                              min: 0,
                              max: 10,
                              thumbHeight: 40,
                              thumbRadius: 20),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 10),
                          thumbColor: Color(0xff553DE8),
                          overlayColor: Color(0x25EB1555),
                          activeTrackColor: Color(0xff553DE8),
                          inactiveTrackColor: Color(0xffaaaaaa)),
                      child: Slider(
                        onChanged: (value) {
                          _controller.setVolume(value);
                        },
                        value: _controller.value.volume,
                        max: 1,
                        min: 0,
                        // activeColor: Color(0xff553DE8),
                        // inactiveColor: Color(0xffaaaaaa),
                      )),
                ),
                Icon(
                  Icons.volume_up,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
