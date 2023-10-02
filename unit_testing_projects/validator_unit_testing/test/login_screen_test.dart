import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:validator_unit_testing/q.dart';
import 'package:validator_unit_testing/screens/login_screen.dart';

void main() {
  group(
    "test login screen",
    () {
      ///______________________________title______________________________///
      testWidgets("should have title in Login screen",
          (WidgetTester tester) async {
        ///ARRANGE
        await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

        ///ACT
        Finder titleText = find.text("login screen");

        ///ASSERT
        expect(titleText, findsOneWidget);
      });

      ///______________________________email_field______________________________///
      testWidgets("should have email text field in Login screen",
          (WidgetTester tester) async {
        ///ARRANGE
        await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

        ///ACT
        Finder emailTextField = find.byKey(const ValueKey(Q.emailTextFieldId));

        ///ASSERT
        expect(emailTextField, findsOneWidget);
      });

      ///______________________________password_field______________________________///
      testWidgets("should have password text field in Login screen",
          (WidgetTester tester) async {
        ///ARRANGE
        await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

        ///ACT
        Finder passwordTextField =
            find.byKey(const ValueKey(Q.passwordTextFieldId));

        ///ASSERT
        expect(passwordTextField, findsOneWidget);
      });

      ///______________________________login_button______________________________///
      testWidgets("should have login button in Login screen",
          (WidgetTester tester) async {
        ///ARRANGE
        await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

        ///ACT
        Finder loginButton = find.byKey(const ValueKey(Q.loginButton));

        ///ASSERT
        expect(loginButton, findsOneWidget);
      });

      testWidgets(
          "should show required fields text if user didn't enter email or password in Login screen",
          (WidgetTester tester) async {
        ///ARRANGE
        await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

        ///ACT
        Finder loginButton = find.byKey(const ValueKey(Q.loginButton));
        await tester.tap(loginButton);
        await tester.pumpAndSettle();
        Finder emailValidationText = find.text("please enter your email");
        Finder passwordValidationText = find.text("please enter your password");

        ///ASSERT
        expect(emailValidationText, findsOneWidget);
        expect(passwordValidationText, findsOneWidget);
      });


      testWidgets(
          "should show nothing if user enter email and password in Login screen",
              (WidgetTester tester) async {
            ///ARRANGE
            await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

            ///ACT
            Finder loginButton = find.byKey(const ValueKey(Q.loginButton));
            Finder emailTextField = find.byKey(const ValueKey(Q.emailTextFieldId));
            Finder passwordTextField = find.byKey(const ValueKey(Q.passwordTextFieldId));
            await tester.enterText(emailTextField, "mail@test.com");
            await tester.enterText(passwordTextField, "12356vjfj");
            await tester.tap(loginButton);
            await tester.pumpAndSettle();
            Finder emailTextEmpty = find.text("please enter your email");
            Finder emailTextNotValid = find.text("please enter a valid email");
            Finder passwordTextEmpty = find.text("please enter your password");
            Finder passwordTextWrongLength = find.text("password length must be at least 6");
            Finder passwordTextNotValid = find.text("password must contain chars and numbers");

            ///ASSERT
            expect(emailTextEmpty, findsNothing);
            expect(emailTextNotValid, findsNothing);
            expect(passwordTextEmpty, findsNothing);
            expect(passwordTextWrongLength, findsNothing);
            expect(passwordTextNotValid, findsNothing);
          });
    },
  );
}
