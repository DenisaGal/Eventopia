import 'package:email_validator/email_validator.dart';

class InputValidator {
  static String? validate(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? validateEmail(String? value, String errorMessage) {
    if (value != null && !EmailValidator.validate(value)) {
      return errorMessage;
    }
    return null;
  }
}
