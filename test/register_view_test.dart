import 'package:beauty_network_boticario/controllers/register_controller.dart';
import 'package:beauty_network_boticario/viewmodels/register_view_model.dart';
import 'package:beauty_network_boticario/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterViewModel extends Mock implements RegisterViewModel {}

class MockRegisterController extends Mock implements RegisterController {}

void main() {
  Widget buildTestableWidget() {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: RegisterView(
          MockRegisterController(),
        ),
      ),
    );
  }

  final buttonFinder = find.text('Cadastrar');
  final emailErrorMessage = find.text('E-mail é obrigatório');
  final passwordErrorMessage = find.text('Senha é obrigatória');
  final displayNameErrorMessage = find.text('Nome é obrigatório');
  final emailInput = find.byKey(Key('email-input'));
  final passwordInput = find.byKey(Key('password-input'));
  final displayNameInput = find.byKey(Key('displayName-input'));

  testWidgets(
      'expects error messages when email, password and name are not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());

    await tester.tap(buttonFinder);

    await tester.pump(const Duration(milliseconds: 100));

    expect(emailErrorMessage, findsOneWidget);
    expect(passwordErrorMessage, findsOneWidget);
    expect(displayNameErrorMessage, findsOneWidget);
  });

  testWidgets(
      'expects two error message when password and name are not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());

    await tester.tap(emailInput);

    await tester.enterText(emailInput, 'teste@teste.com');

    await tester.tap(buttonFinder);

    await tester.pump(const Duration(milliseconds: 100));

    expect(passwordErrorMessage, findsOneWidget);
    expect(displayNameErrorMessage, findsOneWidget);
  });

  testWidgets('expects two error message when email and name are not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());

    await tester.tap(passwordInput);

    await tester.enterText(passwordInput, 'teste1234');

    await tester.tap(buttonFinder);

    await tester.pump(const Duration(milliseconds: 100));

    expect(emailErrorMessage, findsOneWidget);
    expect(displayNameErrorMessage, findsOneWidget);
  });

  testWidgets(
      'expects two error message when email and password are not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());

    await tester.tap(displayNameInput);

    await tester.enterText(displayNameInput, 'Teste da silva');

    await tester.tap(buttonFinder);

    await tester.pump(const Duration(milliseconds: 100));

    expect(emailErrorMessage, findsOneWidget);
    expect(passwordErrorMessage, findsOneWidget);
  });
}
