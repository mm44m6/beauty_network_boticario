import 'package:beauty_network_boticario/common/validator.dart';
import 'package:beauty_network_boticario/controllers/login_controller.dart';
import 'package:beauty_network_boticario/stores/user_store.dart';
import 'package:beauty_network_boticario/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockLoginController extends Mock implements LoginController {}

class MockUserStore extends Mock implements UserStore {}

void main() {
  Widget buildTestableWidget() {
    return MediaQuery(
      data: MediaQueryData(),
      child: MultiProvider(
        providers: [
          Provider<MockUserStore>(create: (_) => MockUserStore()),
        ],
        child: MaterialApp(
          home: LoginView(
            MockLoginController(),
            Validator(),
          ),
        ),
      ),
    );
  }

  final buttonFinder = find.text('Entrar');
  final emailErrorMessage = find.text('E-mail é obrigatório');
  final passwordErrorMessage = find.text('Senha é obrigatória');
  final emailInput = find.byKey(Key('email-input'));
  final passwordInput = find.byKey(Key('password-input'));

  testWidgets('expects one error message when email is not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<UserStore>.value(
        value: MockUserStore(),
        child: buildTestableWidget(),
      ),
    );

    await tester.tap(passwordInput);

    await tester.enterText(passwordInput, 'teste123');

    await tester.tap(buttonFinder);

    await tester.pump(const Duration(milliseconds: 100));
    expect(emailErrorMessage, findsOneWidget);
  });

  testWidgets('expects one error message when password is not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<UserStore>.value(
        value: MockUserStore(),
        child: buildTestableWidget(),
      ),
    );

    await tester.tap(buttonFinder);

    await tester.tap(emailInput);

    await tester.enterText(emailInput, 'teste@teste.com.br');

    await tester.pump(const Duration(milliseconds: 100));

    expect(passwordErrorMessage, findsOneWidget);
  });

  testWidgets(
      'expects two error messages when password and email are not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<UserStore>.value(
        value: MockUserStore(),
        child: buildTestableWidget(),
      ),
    );
    await tester.pumpWidget(buildTestableWidget());

    await tester.tap(buttonFinder);

    await tester.pump(const Duration(milliseconds: 100));

    expect(passwordErrorMessage, findsOneWidget);
    expect(emailErrorMessage, findsOneWidget);
  });
}
