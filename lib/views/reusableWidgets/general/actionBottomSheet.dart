import 'package:authenticator/utilities/imports/generalImport.dart';

Widget actionBottomSheet(
    {required BuildContext context,
    Function? callback,
    required String title,
    required String subtitle,
    required String buttonText,
    required Color buttonColor,
    required String cancelText,
    int? noOfLineForSubtitle,
    Function? onCancelFunction,
    bool isImportant = false,
    Color? importantColor,
    double height = 260,
    double? subtitleHeight,
    Widget? additional}) {
  return StatefulBuilder(builder: (BuildContext context, StateSetter setter) {
    return Container(
      padding: EdgeInsets.only(
        top: sS(context).cH(height: 24),
        left: sS(context).cW(width: 16),
        right: sS(context).cW(width: 16),
      ),
      decoration: BoxDecoration(
        color: AppColors.white(),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            if (isImportant) ...[
              SvgPicture.asset(
                'assets/info.svg',
                color: importantColor,
                height: sS(context).cH(height: 40),
              ),
              const S(h: 24)
            ],
            GeneralTextDisplay(
              title,
              AppColors.black(),
              1,
              20,
              FontWeight.w500,
              title,
              textAlign: TextAlign.center,
            ),
            const S(h: 16),
            S(
              w: 358,
              h: ((subtitle.length / 50) * 25).roundToDouble(),
              child: GeneralTextDisplay(
                subtitle,
                AppColors.gray3(),
                (subtitle.length / 40.0).ceil(),
                13,
                FontWeight.w400,
                subtitle,
                textAlign: TextAlign.center,
              ),
            ),
            additional ?? Container(),
            const S(h: 16),
            const Divider(),
            const S(h: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttonNoPositioned(context,
                    text: cancelText,
                    textColor: AppColors.gray3(),
                    buttonColor: AppColors.gray6(),
                    width: 170, navigator: () {
                  if (onCancelFunction == null) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    onCancelFunction();
                  }
                }),
                buttonNoPositioned(context,
                    text: buttonText,
                    widget: GeneralTextDisplay(buttonText, AppColors.white(), 1,
                        14, FontWeight.w500, buttonText),
                    textColor: AppColors.white(),
                    buttonColor: buttonColor,
                    width: 170, navigator: () {
                  if (callback == null) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    callback();
                  }
                }),
              ],
            ),
            const S(h: 36)
          ],
        ),
      ),
    );
  });
}
