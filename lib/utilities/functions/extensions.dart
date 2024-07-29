// creating extension in flutter
extension E on String {
  String lastChars(int n) => substring(length - n);
}

extension CapitalizeFirstLetter on String {
  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension IntExtensions on int {
  ///returns a String with leading zeros.
  ///1 would be with the [numberOfTotalDigits] = 3 lead to a string '001'
  String addLeadingZeros(int numberOfTotalDigits) =>
      toString().padLeft(numberOfTotalDigits, '0');
}
