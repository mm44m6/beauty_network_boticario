import 'package:beauty_network_boticario/common/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validator', () {
    final validator = Validator();

    test('value returned should be false if email is invalid', () {
      final invalidEmailCaseOne = validator.isEmailValid('email@ema');
      final invalidEmailCaseTwo = validator.isEmailValid('email');
      final invalidEmailCaseThree = validator.isEmailValid('email@ema.');

      expect(invalidEmailCaseOne, false);
      expect(invalidEmailCaseTwo, false);
      expect(invalidEmailCaseThree, false);
    });

    test('value returned should be true if email is valid', () {
      final validEmail = validator.isEmailValid('email@email.com');

      expect(validEmail, true);
    });
  });
}
