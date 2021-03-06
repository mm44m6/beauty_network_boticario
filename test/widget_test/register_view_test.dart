import 'package:beauty_network_boticario/common/validator.dart';
import 'package:beauty_network_boticario/controllers/register_controller.dart';
import 'package:beauty_network_boticario/stores/user_store.dart';
import 'package:beauty_network_boticario/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockRegisterController extends Mock implements RegisterController {}

class MockUserStore extends Mock implements UserStore {}

void main() {
  group('RegisterView', () {
    Widget buildTestableWidget() {
      return Provider<UserStore>.value(
        value: MockUserStore(),
        child: MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: RegisterView(
              MockRegisterController(),
              Validator(),
            ),
          ),
        ),
      );
    }

    final buttonFinder = find.text('Cadastrar');
    final emptyEmailErrorMessage = find.text('E-mail é obrigatório');
    final invalidEmailErrorMessage = find.text('Esse e-mail não é valido');
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

      expect(emptyEmailErrorMessage, findsOneWidget);
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

    testWidgets(
        'expects two error message when email and name are not provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());

      await tester.tap(passwordInput);

      await tester.enterText(passwordInput, 'teste1234');

      await tester.tap(buttonFinder);

      await tester.pump(const Duration(milliseconds: 100));

      expect(emptyEmailErrorMessage, findsOneWidget);
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

      expect(emptyEmailErrorMessage, findsOneWidget);
      expect(passwordErrorMessage, findsOneWidget);
    });

    testWidgets('expects error message when email provided is invalid',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());

      await tester.tap(emailInput);

      await tester.enterText(emailInput, 'teste@');

      await tester.tap(passwordInput);

      await tester.enterText(passwordInput, 'teste1234');

      await tester.tap(displayNameInput);

      await tester.enterText(displayNameInput, 'Teste da silva');

      await tester.tap(buttonFinder);

      await tester.pump(const Duration(milliseconds: 100));

      expect(invalidEmailErrorMessage, findsOneWidget);
    });

    testWidgets(
        'expects no error message when all informations are provided and email is valid',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());

      await tester.tap(emailInput);

      await tester.enterText(emailInput, 'teste@teste.com.br');

      await tester.tap(passwordInput);

      await tester.enterText(passwordInput, 'teste1234');

      await tester.tap(displayNameInput);

      await tester.enterText(displayNameInput, 'Teste da silva');

      await tester.tap(buttonFinder);

      await tester.pump(const Duration(milliseconds: 100));

      expect(invalidEmailErrorMessage, findsNothing);
      expect(passwordErrorMessage, findsNothing);
      expect(emptyEmailErrorMessage, findsNothing);
      expect(displayNameErrorMessage, findsNothing);
    });
  });
}
