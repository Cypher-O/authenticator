import '../../../utilities/imports/generalImport.dart';

Widget subheading(BuildContext context, String text, {bool noPadding = false}) {
  return Padding(
    padding: noPadding
        ? EdgeInsets.zero
        : EdgeInsets.only(
            left: sS(context).cW(width: hPadding),
          ),
    child: GeneralTextDisplay(text, AppColors.black(), 1, 12, FontWeight.w500, text),
  );
}
