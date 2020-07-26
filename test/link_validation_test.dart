import 'package:flutter_test/flutter_test.dart';
import 'package:hackathon_media_player/components/searchBar.dart';

void main() {
  test('Link should be returned from an input string', () {
    String test1 = "Hi my website is https://ishandeveloper.com";
    String test2 = "http://google.com";
    String test3 = "https://ishandeveloper.com/assets/video.mp4";
    String test4 = "a.mp4";
    String test5 = "testing http://ishandeveloper.com/assets/study.mp4";

    expect(linkValidator(test1), 0);
    expect(linkValidator(test2), 0);
    expect(linkValidator(test3), "https://ishandeveloper.com/assets/video.mp4");
    expect(linkValidator(test4), 'a.mp4');
    expect(linkValidator(test5), "http://ishandeveloper.com/assets/study.mp4");
  });
}
