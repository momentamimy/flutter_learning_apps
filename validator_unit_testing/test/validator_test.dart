import 'package:flutter_test/flutter_test.dart';
import 'package:validator_unit_testing/validator.dart';

void main() {
  group("test validator class for ", () {
    ///_____________________________validateEmail____________________________________///
    group(
      "test validateEmail function",
      () {
        test("test empty email", () {
          //arrange
          const email = "";
          //act
          final validationText = AppValidator.validateEmail(email);
          //assert
          expect(validationText, "please enter your email");
        });

        test("test invalid email", () {
          //arrange
          const email = "fasmf@elpd";
          //act
          final validationText = AppValidator.validateEmail(email);
          //assert
          expect(validationText, "please enter a valid email");
        });

        test("test valid email", () {
          //arrange
          const email = "momentamimy@gmail.com";
          //act
          final validationText = AppValidator.validateEmail(email);
          //assert
          expect(validationText, null);
        });
      },
    );
///_____________________________validatePassword______________________________________///
    group("test validatePassword function", () {
      test("test empty password", () {
        //arrange
        const password = "";
        //act
        final validationText = AppValidator.validatePassword(password);
        //assert
        expect(validationText, "please enter your password");
      });

      test("test password length", () {
        //arrange
        const password = "fa46d";
        //act
        final validationText = AppValidator.validatePassword(password);
        //assert
        expect(validationText, "password length must be at least 6");
      });

      test("test password numbers and chars", () {
        //arrange
        const password = "fadadqd";
        //act
        final validationText = AppValidator.validatePassword(password);
        //assert
        expect(validationText, "password must contain chars and numbers");
      });

      test(
        "test valid password",
        () {
          //arrange
          const password = "qqqq1111";
          //act
          final validationText = AppValidator.validatePassword(password);
          //assert
          expect(validationText, null);
        },
      );
    });
  });
}
