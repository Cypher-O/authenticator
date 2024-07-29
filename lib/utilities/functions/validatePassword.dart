// bool isValidPassword(String value) {
//   String pattern =
//       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
//   RegExp regExp =  RegExp(pattern);
//   return regExp.hasMatch(value);
// }

// (?=.*?[A-Za-z]) ensures that there is at least one alphabetical character (uppercase or lowercase).
// (?=.*?[0-9]) ensures that there is at least one numeric character.
// (?=.*?[!@#\$&*~]) ensures that there is at least one special character from the set !@#$&*~.
// .{8,} specifies that the password must be at least 8 characters long.
bool isValidPassword(String value) {
  // Ensure the password is at least 12 characters long
  String pattern = r'^.{5,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool validateName(String name) {
  // Allow special characters, but make them optional
  bool hasSpecialCharacters = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(name);

  return name.length > 2 &&
      (hasSpecialCharacters ||
          !name.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]')));
}
