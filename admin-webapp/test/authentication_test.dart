import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:smart_admin_dashboard/main.dart' as app;
import 'package:smart_admin_dashboard/core/widgets/app_button_widget.dart';

String TEST_EMAIL = "test@example.com";
String TEST_PASSWORD = "password";
String TEST_WRONG_PASSWORD = "password1";

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Simple Test", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text("Region"), findsWidgets);
  });
  testWidgets("Successful login attempt", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    final emailText = find.byKey(Key('loginEmail'));
    final passwordText = find.byKey(Key('loginPassword'));
    final loginButton = find.text("Sign In");

    await tester.tap(emailText);
    await tester.enterText(emailText, TEST_EMAIL);
    expect(find.text(TEST_EMAIL), findsOneWidget);

    await tester.tap(passwordText);
    await tester.pumpAndSettle();
    await tester.enterText(passwordText, TEST_PASSWORD);
    await tester.pumpAndSettle();
    expect(find.text(TEST_PASSWORD), findsOneWidget);

    await tester.tap(loginButton);
  });
  testWidgets("Unsuccessful attempt login", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    final emailText = find.byKey(Key('loginEmail'));
    final passwordText = find.byKey(Key('loginPassword'));
    final loginButton = find.text("Sign In");

    await tester.tap(emailText);
    await tester.enterText(emailText, TEST_EMAIL);
    expect(find.text(TEST_EMAIL), findsOneWidget);

    await tester.tap(passwordText);
    await tester.pumpAndSettle();
    await tester.enterText(passwordText, TEST_WRONG_PASSWORD);
    await tester.pumpAndSettle();
    expect(find.text(TEST_PASSWORD), findsOneWidget);

    await tester.tap(loginButton);
  });
}
