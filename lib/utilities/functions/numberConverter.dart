String k_m_b_generator(num number) {
  if (number > 999 && number < 99999) {
    return "${(number / 1000).round().toString()} K";
  } else if (number > 99999 && number < 999999) {
    return "${(number / 1000)..round().toString()} K";
  } else if (number > 999999 && number < 999999999) {
    return "${(number / 1000000).round().toString()} M";
  } else if (number > 999999999) {
    return "${(number / 1000000000).round().toString()} B";
  } else {
    return number.toString();
  }
}

// String k_m_b_t_generator(num number) {
//   if (number >= 1000 && number < 999999) {
//     // For numbers in the "K" range, display with exactly two decimal places
//     return "${(number / 1000).toStringAsFixed(2)}K";
//   } else if (number >= 999999 && number < 999999999) {
//     // Display in millions with no decimal places and the "M" suffix
//     return "${(number / 1000000).round()}M";
//   } else if (number >= 999999999 && number < 999999999999) {
//     // Display in billions with no decimal places and the "B" suffix
//     return "${(number / 1000000000).round()}B";
//   } else if (number >= 999999999999) {
//     // Display in trillions with no decimal places and the "T" suffix
//     return "${(number / 1000000000000).round()}T";
//   } else {
//     // For numbers less than 1000 and those not specifically handled, return the original number
//     return number.toString();
//   }
// }

String k_m_b_t_generator(num number) {
  // if (number > 999 && number < 99999) {
  //   return "${(number / 1000).round().toStringAsFixed(2)}K";
  // } else 
  if (number > 99999 && number < 999999) {
    return "${(number / 1000).round().toStringAsFixed(2)}K";
  } else if (number > 999999 && number < 999999999) {
    return "${(number / 1000000).round().toString()}M";
  } else if (number > 999999999 && number < 999999999999) {
    return "${(number / 1000000000).round().toString()}B";
  } else if (number > 999999999999) {
    return "${(number / 1000000000000).round().toString()}T";
  } else {
    return number.toString();
  }
}

// change month to years plus month
String monthsToYear(int value) {
  if (value == 1) {
    return "1 Month";
  }
  if (value < 12) {
    return "$value Months";
  }
  if (value >= 12) {
    String year = (value / 12).floor().toString();
    int month = value % 12;
    return "$year ${int.parse(year) == 1 ? "Year" : "Years"}${month > 0 ? ", $month ${month == 1 ? "Month" : "Months"}" : ""}";
  } else {
    return "";
  }
}

String formatPhoneNumber(String phoneNumber, {String code = '234'}) {
  String formatted = '';
  if (phoneNumber != "") {
    if (phoneNumber[0] == '0') {
      formatted = code + phoneNumber.substring(1);
    } else {
      formatted = code + phoneNumber;
    }
  }
  return formatted;
}

String formatPhoneNumberBack(String phoneNumber, {String code = '234'}) {
  String formatted = '';
  List splitList = phoneNumber.split(code);
  if (splitList.length == 1) {
    formatted = splitList[0];
  } else {
    formatted = '0' + splitList[1];
  }
  return formatted;
}
