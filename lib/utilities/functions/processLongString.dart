// this is used to return the substring of a long string
// that might possibly overflow when put inside a widget
import 'package:authenticator/utilities/imports/functionImport.dart';

String processLongString(
    {required String unProcessedString,
    required int minimumStringLength,
    required int substringLength}) {
  return unProcessedString.length > minimumStringLength
      ? "${unProcessedString.substring(0, substringLength)}.."
      : unProcessedString;
}

processLongDouble(
    {required String unProcessedDoubleString,
    required int maximumStringLength}) {
  String processString =
      (double.parse(unProcessedDoubleString.replaceAll(",", ""))).toString();
  if (processString.contains('.') &&
      int.parse(processString.split('.')[1]) == 0) {
    processString = processString.split('.')[0];
  }
  return processString.length > maximumStringLength
      ? displayWithComma(
          k_m_b_generator(double.parse(unProcessedDoubleString.toString())))
      : displayWithComma(processString);
}

// String processLongDoubleCurrency({
//   required String unProcessedDoubleString,
//   required int maximumStringLength,
// }) {
//   // Remove currency symbol and any other non-numeric characters
//   String cleanedString =
//       unProcessedDoubleString.replaceAll(RegExp(r'[^\d.]'), '');

//   print("Cleaned string: $cleanedString"); // Print the cleaned string

//   try {
//     double parsedDouble = double.parse(cleanedString);
//     String processString = parsedDouble.toString();

//     if (processString.contains('.') &&
//         int.parse(processString.split('.')[1]) == 0) {
//       processString = processString.split('.')[0];
//     }

//     return processString.length > maximumStringLength
//         ? displayWithComma(k_m_b_t_generator(parsedDouble))
//         : displayWithComma(processString);
//   } catch (e) {
//     // Log the error for debugging
//     print("Error parsing double: $e");
//     // Optionally, you can rethrow the exception if you want to propagate it
//     // throw e;
//     // Or handle the error in some other way if needed
//     return double.parse(cleanedString).toString();
//   }
// }
String processLongDoubleCurrency({
  required String unProcessedDoubleString,
  required int maximumStringLength,
}) {
  // Remove currency symbol and any other non-numeric characters
  String cleanedString =
      unProcessedDoubleString.replaceAll(RegExp(r'[^\d.]'), '');

  try {
    double parsedDouble = double.parse(cleanedString);
    String result;

    // if (parsedDouble >= 99999 && parsedDouble < 9999999) {
    //   // For numbers in the "K" range, display with exactly two decimal places
    //   result = "${(parsedDouble / 1000).toStringAsFixed(2)}K";
    // } else if (parsedDouble >= 0 && parsedDouble < 1000) {
    //   // For numbers between 0 and 999, display with ".00" at the back
    //   result = parsedDouble.toStringAsFixed(2);
    // } else {
    // For other numbers, use the original value with comma separator
    result = parsedDouble.toStringAsFixed(2);
    // }

    return result.length > maximumStringLength
        ? displayWithComma(k_m_b_t_generator(parsedDouble))
        : displayWithComma(result);
  } catch (e) {
    // Log the error for debugging
    print("Error parsing double: $e");
    // Optionally, you can rethrow the exception if you want to propagate it
    // throw e;
    // Or handle the error in some other way if needed
    return double.parse(cleanedString).toString();
  }
}



// processLongDoubleCurrency(
//     {required String unProcessedDoubleString,
//     required int maximumStringLength}) {
//   String processString =
//       (double.parse(unProcessedDoubleString.replaceAll(",", ""))).toString();
//   if (processString.contains('.') &&
//       int.parse(processString.split('.')[1]) == 0) {
//     processString = processString.split('.')[0];
//   }
//   ;
//   return processString.length > maximumStringLength
//       ? displayWithComma(
//           k_m_b_t_generator(double.parse(unProcessedDoubleString.toString())))
//       : displayWithComma(processString);
// }
