// this is a general back button for the pages
import 'package:authenticator/utilities/imports/generalImport.dart';

Widget backButton(BuildContext context,
    {double top = 30,
    double left = 16,
    Color? color,
    Color? arrowColor,
    double? size,
    String? navigateTo,
    Function? navigator,
    String? pageName}) {
  return AdaptivePositioned(
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (navigator != null)
              ? () {
                  navigator();
                }
              : (navigateTo != null)
                  ? () {
                      context.goNamed(navigateTo);
                    }
                  : () {
                      Navigator.pop(context);
                    },
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: arrowColor ?? AppColors.black(),
              ),
              const S(w: 10),
              GeneralTextDisplay(
                pageName ?? "Back",
                AppColors.black(),
                1,
                18,
                FontWeight.w500,
                "Scan QR Code",
              ),
            ],
          ),
          // Container(
          //   height: sS(context).cH(height: size ?? 40),
          //   width: sS(context).cW(width: size ?? 40),
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: color ?? blue.withOpacity(0.1)),
          //   child: GeneralIconDisplay(
          //       LineIcons.arrowLeft, arrowColor ?? blue, UniqueKey(), 20),
          // ),
        ),
      ],
    ),
    top: top,
    left: left,
  );
}
