import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hackathon_media_player/components/searchBar.dart';

void main() {
  testWidgets('Main App Widget Test Checking If Tree Is Broken',
      (WidgetTester tester) async {
    await tester.pumpWidget(SearchBar());
    expect(find.text('Type or paste a video link'), findsOneWidget);
  });
}
