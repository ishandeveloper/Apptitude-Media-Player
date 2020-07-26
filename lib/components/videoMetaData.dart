import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoMetaData extends StatelessWidget {
  const VideoMetaData({
    Key key,
    @required Duration position,
    @required this.muted,
  })  : _position = position,
        super(key: key);

  final Duration _position;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: [
                  _position?.inSeconds.toString().length == 1
                      ? Text(
                          "${_position?.inMinutes?.toString()}:0${_position?.inSeconds?.toString()}",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      : Text(
                          "${_position?.inMinutes?.toString()}:${_position?.inSeconds?.toString()}",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                ],
              ),
            ),
            if (muted)
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    Icon(
                      Icons.volume_mute,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Tap To Unmute",
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
