// this class is to validate username
bool isValidUserName(String input) {
  final RegExp regex = RegExp(r"^.{5,}$");
  return regex.hasMatch(input);
}
