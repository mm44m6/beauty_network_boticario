import 'package:beauty_network_boticario/controllers/home_controller.dart';
import 'package:beauty_network_boticario/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHomeController extends Mock implements HomeController {}

void main() {
  Widget buildTestableWidget() {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(home: HomeView(MockHomeController())),
    );
  }

  final buttonFinder = find.text('Postar');
  final emptyPostErrorMessage = find.text('Não é possivel fazer post vazio!');
  final textInput = find.byKey(Key('post-text-input'));

  testWidgets('expects error message when post input is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());

    await tester.tap(buttonFinder);

    await tester.pump(const Duration(milliseconds: 100));

    expect(emptyPostErrorMessage, findsOneWidget);
  });
}
