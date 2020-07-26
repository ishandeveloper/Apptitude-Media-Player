import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hackathon_media_player/components/videoMetaData.dart';

void main() {
  testWidgets('Main App Widget Test Checking If Tree Is Broken',
      (WidgetTester tester) async {
    await tester.pumpWidget(VideoMetaData(
      position: Duration(seconds: 32),
      muted: false,
    ));

    var mediaPlayerApp = find.byType(Positioned);
    expect(mediaPlayerApp, findsOneWidget);
  });
}
