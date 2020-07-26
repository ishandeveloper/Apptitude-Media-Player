import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon_media_player/pages/searchedVideo.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController controller = TextEditingController();
  bool isInvalidLink = false;

  void linkValidator(value) {
    RegExp exp =
        new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');

    var url = exp.firstMatch(value);
    if (url != null) {
      var link = url.input.substring(url.start, url.end);
      if (link.contains('.mp4')) {
        controller.clear();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchedVideo(
                url: link,
              ),
            ));
      } else {
        setState(() {
          isInvalidLink = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xff222537),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
              child: TextField(
                controller: controller,
                maxLines: 1,
                minLines: 1,
                onSubmitted: linkValidator,
                style: GoogleFonts.poppins(color: Colors.white),
                autofocus: false,
                decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.white),
                    hintText: "Type or paste a video link",
                    hintStyle: GoogleFonts.poppins(color: Colors.white),
                    border: InputBorder.none),
              ),
            ),
          ),
          if (isInvalidLink)
            SizedBox(
              height: 10,
            ),
          if (isInvalidLink)
            Text(
                "Only .mp4 files are currently supported. Please enter a valid url.",
                style: GoogleFonts.poppins(color: Colors.red, fontSize: 12))
        ],
      ),
    );
  }
}
