import 'package:cached_video_player/cached_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_media_player/components/searchBar.dart';
import 'package:hackathon_media_player/components/topText.dart';
import 'package:hackathon_media_player/components/video.dart';

final feedReference = Firestore.instance.collection("videos");
List<CachedVideoPlayerController> videoControllers = [];

class VideoFeed extends StatefulWidget {
  @override
  _VideoFeedState createState() => _VideoFeedState();
}

class _VideoFeedState extends State<VideoFeed> {
  int currentlyUnmuted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("videos")
            .orderBy('timestamp')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("ERROR"));
          } else if (!snapshot.hasData || snapshot.data.documents.length == 0) {
            return Center(child: Text("Come on, Upload Something!"));
          }
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TopText(),
                  SearchBar(),
                  ListView.separated(
                    itemCount: snapshot.data.documents.length,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    cacheExtent: 10,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        Divider(height: 20, color: Colors.black, thickness: 0),
                    itemBuilder: (context, index) {
                      videoControllers.add(CachedVideoPlayerController.network(
                          snapshot.data.documents[index]['url']));

                      return Video(
                        mainController: videoControllers[index],
                        postkey: index,
                        unmutePlayer: () {
                          if (currentlyUnmuted != null) {
                            videoControllers[currentlyUnmuted].setVolume(0);
                          }
                          videoControllers[index].setVolume(100);
                          currentlyUnmuted = index;
                        },
                        mutePlayer: () {
                          if (currentlyUnmuted == index) {
                            currentlyUnmuted = null;
                          }
                          videoControllers[index].setVolume(0);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
