import 'package:flutter/material.dart';

class VideoFullScreenButton extends StatelessWidget {
  VideoFullScreenButton({@required this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: SafeArea(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                borderRadius: BorderRadius.circular(25)),
            child: Icon(
              Icons.fullscreen,
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }
}
