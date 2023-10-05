import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:validator_unit_testing/q.dart';
import 'package:validator_unit_testing/screens/login_screen.dart';

void main() {
  group(
    "test login screen",
    () {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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
        await tester.pump(const Duration(seconds: 2));
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
        Finder passwordTextField =
            find.byKey(const ValueKey(Q.passwordTextFieldId));
        await tester.enterText(emailTextField, "mail@test.com");
        await tester.enterText(passwordTextField, "12356vjfj");
        await tester.tap(loginButton);
        await tester.pumpAndSettle();
        Finder welcomeText = find.text("welcome screen");

        ///ASSERT
        await tester.pump(const Duration(seconds: 2));
        expect(welcomeText, findsOneWidget);
      });
    },
  );
}
