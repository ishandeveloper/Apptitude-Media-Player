import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hackathon_media_player/components/topText.dart';

void main() {
  testWidgets('Checking Top Text having Title', (WidgetTester tester) async {
    await tester.pumpWidget(TopText());
    find.byType(Text);
    expect(find.text('Media Player'), findsOneWidget);
  });
}
