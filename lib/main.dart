import 'package:flutter/material.dart';
import 'package:hackathon_media_player/pages/videoFeed.dart';

void main() {
  runApp(MediaPlayerApp());
}

class MediaPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VideoFeed(),
    );
  }
}
