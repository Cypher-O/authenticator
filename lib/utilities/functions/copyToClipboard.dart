import 'package:authenticator/utilities/imports/generalImport.dart';

void copyToClipboard(
    {required BuildContext context,
    // required String? text,
    required String text,
    String successText = 'Copied to clipboard'}) {
  Clipboard.setData(ClipboardData(text: text)).then((_) {
    showCustomSnackbar(context: context, text: successText);
  });
}

void showCustomSnackbar({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: const Duration(milliseconds: 400),
  ));
}
