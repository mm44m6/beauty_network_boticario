import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget() {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(home: Container()),
    );
  }

  testWidgets('expects one error message when email is not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());
  });
}
