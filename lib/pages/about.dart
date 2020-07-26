import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1F2128),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://raw.githubusercontent.com/ishandeveloper/ishandeveloper.github.io/master/assets/img/profile2.jpg'))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey, I'm Ishan!",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 26),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: Text(
                          "I make elegantly professional web apps and flutter apps for a living and also design user experiences. Each and every single interaction in this app is crafted with lots of love. If you want me to do any one of these for you, get in touch with me.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.5),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AboutButton(
                        icon: LineIcons.github,
                        url: "https://github.com/ishandeveloper",
                        title: "github.com/ishandeveloper",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AboutButton(
                        icon: LineIcons.linkedin,
                        url: "https://linkedin.com/in/ishandeveloper",
                        title: "linkedin.com/in/ishandeveloper",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AboutButton(
                        icon: LineIcons.medium,
                        url: "https://medium.com/@ishandeveloper",
                        title: "medium.com/@ishandeveloper",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AboutButton(
                        icon: LineIcons.globe,
                        url: "https://ishandeveloper.com",
                        title: "www.ishandeveloper.com",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AboutButton(
                        icon: LineIcons.stack_exchange,
                        url:
                            "https://stackoverflow.com/users/13219775/ishandeveloper",
                        title: "stackoverflow",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AboutButton(
                        icon: LineIcons.wordpress,
                        url: "http://blog.ishandeveloper.com",
                        title: "blog.ishandeveloper.com",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Made with ❤ by",
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "  @ishandeveloper",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}

class AboutButton extends StatelessWidget {
  final IconData icon;
  final String url;
  final String title;

  AboutButton({this.icon, this.url, this.title});

  @override
  Widget build(BuildContext context) {
    _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Container(
      margin: EdgeInsets.only(right: 24),
      child: OutlineButton(
        onPressed: () => _launchURL(url),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
