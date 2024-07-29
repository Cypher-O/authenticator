// class to validate phone number

import '../imports/generalImport.dart';

class ValidatePhoneNumber {
  // function to validate phone number with +234
  static bool isValidNumber(String input) {
    final RegExp regex = RegExp(r'^(?:[+]13)?[0-9]{14}$');
    regex.hasMatch(input)
        ? debugPrint("$input validated")
        : debugPrint("$input invalidated");
    return regex.hasMatch(input);
  }
  // function to validate phone number

  bool isValidPhone(String input) {
    // for phone number of length 10
    // final RegExp regex = RegExp(r'^[0][7|8|9][0|1]\d{7}$');
    // for phone number of length 11
    final RegExp regex2 = RegExp(r'^[0][7|8|9][0|1]\d{8}$');
    // regex.hasMatch(input)?debugPrint("$input validated"):debugPrint("$input invalidated");
    // return regex.hasMatch(input) || regex2.hasMatch(input);
    return regex2.hasMatch(input);
  }

  bool isValidLogin(String input) {
    final RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?\.[a-zA-Z0-9]{2,}$");
    // final RegExp phoneNumberRegex = RegExp(r'^[0-9]{3}[0-9]*$');
    final RegExp phoneNumberRegex = RegExp(r'^[0-9]{11}$');

    if (input.isEmpty) {
      // Not enough characters to determine validity
      return false;
    } else if (input.startsWith(RegExp(r'^[a-zA-Z]'))) {
      // Starts with a letter, likely an email address
      return emailRegex.hasMatch(input);
    } else {
      // Starts with a number, likely a phone number
      return phoneNumberRegex.hasMatch(input);
    }
  }
}
