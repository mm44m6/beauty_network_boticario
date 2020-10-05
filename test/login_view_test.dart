import 'package:beauty_network_boticario/controllers/login_controller.dart';
import 'package:beauty_network_boticario/viewmodels/login_view_model.dart';
import 'package:beauty_network_boticario/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLoginViewModel extends Mock implements LoginViewModel {}

class MockLoginController extends Mock implements LoginController {}

void main() {
  Widget buildTestableWidget() {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: LoginView(
          MockLoginController(),
        ),
      ),
    );
  }

  final buttonFinder = find.text('Entrar');
  final emailErrorMessage = find.text('E-mail é obrigatório');
  final passwordErrorMessage = find.text('Senha é obrigatória');
  final emailInput = find.byKey(Key('email-input'));
  final passwordInput = find.byKey(Key('password-input'));

  testWidgets('expect one error message when email is not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());

    await tester.enterText(passwordInput, 'teste123');

    await tester.tap(buttonFinder);

    await tester.pump(const Duration(milliseconds: 100));
    expect(emailErrorMessage, findsOneWidget);
  });

  testWidgets('expect one error message when password is not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());

    await tester.tap(buttonFinder);

    await tester.enterText(emailInput, 'teste@teste.com.br');

    await tester.pump(const Duration(milliseconds: 100));

    expect(passwordErrorMessage, findsOneWidget);
  });

  testWidgets(
      'expect two error messages when password and email are not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());

    await tester.tap(buttonFinder);

    await tester.pump(const Duration(milliseconds: 100));

    expect(passwordErrorMessage, findsOneWidget);
    expect(emailErrorMessage, findsOneWidget);
  });

  testWidgets('expect no errors when password and email are provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());

    await tester.enterText(emailInput, 'teste@teste.com.br');
    await tester.enterText(passwordInput, 'teste123');

    await tester.tap(buttonFinder);

    await tester.pump(const Duration(milliseconds: 100));

    expect(passwordErrorMessage, findsNothing);
    expect(emailErrorMessage, findsNothing);
  });
}
