import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/user_registration_form.dart';

void main() {
  group('Email Validation', () {
    test('Valid emails pass', () {
      expect(isValidEmail('test@example.com'), true);
      expect(isValidEmail('user.name@domain.co'), true);
    });

    test('Invalid emails fail', () {
      expect(isValidEmail('a@'), false);
      expect(isValidEmail('@b.com'), false);
      expect(isValidEmail('plainaddress'), false);
    });
  });

  group('Password Validation', () {
    test('Strong password passes', () {
      expect(isValidPassword('Aa1!aaaa'), true);
    });

    test('Weak password fails', () {
      expect(isValidPassword('12345678'), false); // فقط أرقام
      expect(isValidPassword('abcdefgh'), false); // فقط أحرف صغيرة
      expect(isValidPassword('ABCDEFGH'), false); // فقط أحرف كبيرة
      expect(isValidPassword('Abcdefgh'), false); // بدون رقم أو رمز
    });
  });
}
