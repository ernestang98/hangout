import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/screens/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_ui_kit/screens/register.dart';

import 'Services/AuthenticationService.dart';

void main() {
  group('Widget testing', ()
  {
    testWidgets(
        'Password for login should have have special character,'
            ' number, uppercase character and lowercase character', (
        WidgetTester tester) async {
      final emailField = find.byKey(ValueKey('email'));
      final passwordField = find.byKey(ValueKey('password'));
      final login = find.byKey(ValueKey('login'));
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      await tester.enterText(emailField, "zf@gmail.com");
      await tester.enterText(passwordField, "Zhifah123");
      await tester.tap(login);
      await tester.pump();
      expect(find.text('Password must have at least one special character'),
          findsOneWidget);
    });

    testWidgets(
        'Password for login should have minimum length of 6', (
        WidgetTester tester) async {
      final emailField = find.byKey(ValueKey('email'));
      final passwordField = find.byKey(ValueKey('password'));
      final login = find.byKey(ValueKey('login'));
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      await tester.enterText(emailField, "zf@gmail.com");
      await tester.enterText(passwordField, "pw1?");
      await tester.tap(login);
      await tester.pump();
      expect(find.text('Password must contain at least 6 characters'),
          findsOneWidget);
    });

    testWidgets(
        'Password text field for login should not be empty', (
        WidgetTester tester) async {
      final emailField = find.byKey(ValueKey('email'));
      final login = find.byKey(ValueKey('login'));
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      await tester.enterText(emailField, "zf@gmail.com");
      await tester.tap(login);
      await tester.pump();
      expect(find.text('Password cannot be empty.'),
          findsOneWidget);
    });

    testWidgets(
        'Email text field for login should not be empty', (
        WidgetTester tester) async {
      final passwordField = find.byKey(ValueKey('password'));
      final login = find.byKey(ValueKey('login'));
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      await tester.enterText(passwordField, "Password123?");
      await tester.tap(login);
      await tester.pump();
      expect(find.text('Email cannot be empty.'),
          findsOneWidget);
    });

    testWidgets(
        'Invalid email that is not in the database', (
        WidgetTester tester) async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      var emailAddress = "bobtan@gmail.com"; //This email does not exist in the firebase.
      var password = "Password123>";
      dynamic authResult = await AuthenticationService().loginUser(emailAddress, password);
      expect(authResult, null);
    });

    testWidgets(
        'Invalid password', (
        WidgetTester tester) async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      var emailAddress = "zf@gmail.com";
      var password = "Password123>"; //Incorrect password
      dynamic authResult = await AuthenticationService().loginUser(emailAddress, password);
      expect(authResult, null);
    });

    testWidgets(
        'Username text field should not be empty', (
        WidgetTester tester) async {
      final register = find.byKey(ValueKey('register'));
      await tester.pumpWidget(MaterialApp(home: RegisterScreen()));
      await tester.tap(register);
      await tester.pump();
      expect(find.text('Username cannot be empty'),
          findsOneWidget);
    });

    testWidgets(
        'Email text field for sign up should not be empty', (
        WidgetTester tester) async {
      final usernameField = find.byKey(ValueKey('username'));
      final register = find.byKey(ValueKey('register'));
      await tester.pumpWidget(MaterialApp(home: RegisterScreen()));
      await tester.enterText(usernameField, "IeatHam");
      await tester.tap(register);
      await tester.pump();
      expect(find.text('Email cannot be empty.'),
          findsOneWidget);
    });

    testWidgets(
        'Invalid email address keyed in', (
        WidgetTester tester) async {
      final usernameField = find.byKey(ValueKey('username'));
      final emailRegField = find.byKey(ValueKey('reg_email'));
      final register = find.byKey(ValueKey('register'));
      await tester.pumpWidget(MaterialApp(home: RegisterScreen()));
      await tester.enterText(usernameField, "IeatHam");
      await tester.enterText(emailRegField, "ham"); //invalid email address
      await tester.tap(register);
      await tester.pump();
      expect(find.text('Please enter a valid email address'),
          findsOneWidget);
    });

    testWidgets(
        'Password for registration should have have special character,'
            ' number, uppercase character and lowercase character', (
        WidgetTester tester) async {
      final usernameField = find.byKey(ValueKey('username'));
      final emailRegField = find.byKey(ValueKey('reg_email'));
      final passwordRegField = find.byKey(ValueKey('reg_password'));
      final register = find.byKey(ValueKey('register'));
      await tester.pumpWidget(MaterialApp(home: RegisterScreen()));
      await tester.enterText(usernameField, "IeatHam");
      await tester.enterText(emailRegField, "zflam@gmail.com");
      await tester.enterText(passwordRegField, "Zhifah123");
      await tester.tap(register);
      await tester.pump();
      expect(find.text('Password must have at least one special character'),
          findsOneWidget);
    });

    testWidgets(
        'Password for registration should have have at least 6 characters', (
        WidgetTester tester) async {
      final usernameField = find.byKey(ValueKey('username'));
      final emailRegField = find.byKey(ValueKey('reg_email'));
      final passwordRegField = find.byKey(ValueKey('reg_password'));
      final register = find.byKey(ValueKey('register'));
      await tester.pumpWidget(MaterialApp(home: RegisterScreen()));
      await tester.enterText(usernameField, "IeatHam");
      await tester.enterText(emailRegField, "zflam@gmail.com");
      await tester.enterText(passwordRegField, "pw1?");
      await tester.tap(register);
      await tester.pump();
      expect(find.text('Password must contain at least 6 characters'),
          findsOneWidget);
    });

    testWidgets(
        'Password for registration should not be empty', (
        WidgetTester tester) async {
      final usernameField = find.byKey(ValueKey('username'));
      final emailRegField = find.byKey(ValueKey('reg_email'));
      final register = find.byKey(ValueKey('register'));
      await tester.pumpWidget(MaterialApp(home: RegisterScreen()));
      await tester.enterText(usernameField, "IeatHam");
      await tester.enterText(emailRegField, "zflam@gmail.com");
      await tester.tap(register);
      await tester.pump();
      expect(find.text('Password cannot be empty.'),
          findsOneWidget);
    });

    testWidgets(
        'Email formating is not correct', (
        WidgetTester tester) async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      var username = "ham";
      var emailAddress = "zf";
      var password = "Password123>";
      dynamic result = await AuthenticationService().createNewUser(username , emailAddress, password);
      expect(result, null);
    });
  });
}
