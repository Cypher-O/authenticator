
import '../imports/generalImport.dart';

class NoLeadingZeroInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new value starts with 0 and has more than one digit
    if (newValue.text.startsWith('0') && newValue.text.length > 1) {
      // Remove the leading 0
      return TextEditingValue(
        text: newValue.text.substring(1),
        selection: TextSelection.collapsed(offset: newValue.text.length - 1),
      );
    }
    return newValue;
  }
}