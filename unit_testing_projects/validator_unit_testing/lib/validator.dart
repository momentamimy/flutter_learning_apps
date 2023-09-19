class AppValidator {
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'please enter your email';
    } else if (_checkEmailFormat(email)) {
      return 'please enter a valid email';
    } else {
      return null;
    }
  }

  static bool _checkEmailFormat(String email) {
    RegExp emailRegExp = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
      caseSensitive: false,
      multiLine: false,
    );
    return !emailRegExp.hasMatch(email);
  }

  static String? validatePassword(String password) {

    if (password.isEmpty) {
      return "please enter your password";
    } else if (password.length<6) {
      return "password length must be at least 6";
    } else {
      String pattern = r'^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)$';
      RegExp regExp = RegExp(pattern);
      bool result = regExp.hasMatch(password);
      if(!result) {
        return "password must contain chars and numbers";
      }
      return null;
    }
  }
}
