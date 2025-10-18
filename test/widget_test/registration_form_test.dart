import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/user_registration_form.dart';

void main() {
  testWidgets('UserRegistrationForm widget test', (WidgetTester tester) async {
    // Build the form widget
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    // Find fields by key
    final fullNameField = find.byKey(const Key('fullNameField'));
    final emailField = find.byKey(const Key('emailField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final confirmPasswordField = find.byKey(const Key('confirmPasswordField'));
    final registerButton = find.text('Register');

    // تحقق من ظهور الحقول
    expect(fullNameField, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(confirmPasswordField, findsOneWidget);
    expect(registerButton, findsOneWidget);

    // اترك الحقول فارغة واضغط تسجيل للتحقق من رسالة الخطأ
    await tester.tap(registerButton);
    await tester.pumpAndSettle();
    expect(find.text('Please fix errors before submitting'), findsOneWidget);

    // أدخل بيانات غير صحيحة
    await tester.enterText(fullNameField, 'A'); // اسم قصير
    await tester.enterText(emailField, 'invalidemail');
    await tester.enterText(passwordField, '123');
    await tester.enterText(confirmPasswordField, '456');
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    // تحقق من رسائل التحقق لكل حقل
    expect(find.text('Name must be at least 2 characters'), findsOneWidget);
    expect(find.text('Please enter a valid email'), findsOneWidget);
    expect(find.text('Password is too weak'), findsOneWidget);
    expect(find.text('Passwords do not match'), findsOneWidget);

    // أدخل بيانات صحيحة
    await tester.enterText(fullNameField, 'John Doe');
    await tester.enterText(emailField, 'john@example.com');
    await tester.enterText(passwordField, 'Aa1!aaaa');
    await tester.enterText(confirmPasswordField, 'Aa1!aaaa');

    await tester.tap(registerButton);
    await tester.pump(); // يبدأ التحميل
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 2)); // انتهاء محاكاة API
    await tester.pumpAndSettle();

    // تحقق من ظهور رسالة النجاح
    expect(find.text('Registration successful!'), findsOneWidget);
  });
}
