String extractSubstring(String inputString, {int index = 3}) {
  List<String> splitString = inputString.split(' ');

  if (splitString.length >= 3 && index == 3) {
    return '${splitString[0]} ${splitString[1]} ${splitString[2]}';
  } else if (splitString.length >= 2 && index == 2) {
    return '${splitString[0]} ${splitString[1]}';
  } else if (splitString.isNotEmpty && index == 1) {
    return splitString[0];
  } else {
    return '';
  }
}
