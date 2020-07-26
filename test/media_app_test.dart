import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hackathon_media_player/main.dart';

void main() {
  testWidgets('Main App Widget Test Checking If Tree Is Broken',
      (WidgetTester tester) async {
    await tester.pumpWidget(MediaPlayerApp());

    var mediaPlayerApp = find.byType(MaterialApp);
    expect(mediaPlayerApp, findsOneWidget);
  });
}
