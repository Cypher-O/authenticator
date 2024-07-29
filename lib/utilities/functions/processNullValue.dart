// to process null value
String nvl(String? value, [String? returnValue]) {
  if (value == null && returnValue != null) {
    return returnValue;
  } else if (value != null) {
    return value;
  } else {
    return "";
  }
}
