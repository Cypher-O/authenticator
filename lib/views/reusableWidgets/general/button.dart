// this is the type of button used across the application

import '../../../utilities/imports/generalImport.dart';

Widget button(context,
    {required String text,
    required double top,
    String? navigateTo,
    double? radius,
    Color? buttonColor,
    Color? textColor,
    Function? navigator,
    double? width,
    FontWeight? fontWeight,
    double? right,
    Widget? widget,
    double? height}) {
  return Stack(
    children: [
      rowPositioned(
        child: ButtonWidget(
            navigator ??
                () {
                  // know your customer page
                  Navigator.pushNamed(context, navigateTo ?? '');
                },
            buttonColor ?? AppColors.green(),
            width ?? 297,
            height ?? 52,
            widget ??
                GeneralTextDisplay(text, textColor ?? AppColors.white(), 1, 16,
                    fontWeight ?? FontWeight.w700, text),
            Alignment.center,
            radius ?? 8),
        top: top,
      )
    ],
  );
}

Widget buttonNoPositioned(BuildContext context,
    {String? text = 'No text',
    String? navigateTo,
    double? radius,
    Color? buttonColor,
    Color? textColor,
    Function? navigator,
    double? width,
    FontWeight? fontWeight,
    double? fontSize,
    Widget? widget,
    double? height}) {
  return ButtonWidget(
    navigator ??
        () {
          // know your customer page
          if (navigateTo != null) {
            context.goNamed(navigateTo);
          }
        },
    buttonColor ?? AppColors.green(),
    width ?? 358,
    height ?? 48,
    widget ??
        GeneralTextDisplay(text!, textColor ?? AppColors.white(), 1,
            fontSize ?? 14, fontWeight ?? FontWeight.w500, text),
    Alignment.center,
    radius ?? 8,
    noElevation: 0,
  );
}
