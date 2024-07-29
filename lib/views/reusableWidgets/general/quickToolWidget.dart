import 'package:authenticator/utilities/imports/generalImport.dart';

// Widget quickToolWidget({
//   required BuildContext context,
//   required String icon,
//   required String title,
//   required String subtitle,
//   required String additionalText,
//   required Color titleColor,
//   required Color backgroundColor,
//   required Function callback,
//   bool isFirstItem = false,
//   required Function() generateOtp,
//   required Function(String) updateOtp,
// }) {
//   // Decode base64 image
//   Widget imageWidget;
//   if (icon.isNotEmpty) {
//     String base64String = icon;
//     // Remove data URI scheme prefix if present
//     if (base64String.contains(',')) {
//       base64String = base64String.split(',')[1];
//     }
//     try {
//       final decodedBytes = base64Decode(base64String);
//       imageWidget = Image.memory(
//         decodedBytes,
//         width: sS(context).cW(width: 25),
//         height: sS(context).cH(height: 25),
//         fit: BoxFit.contain,
//         errorBuilder: (context, error, stackTrace) {
//           debugPrint('Error displaying image: $error');
//           return _buildPlaceholder(context);
//         },
//       );
//     } catch (e) {
//       debugPrint('Error decoding base64 image: $e');
//       imageWidget = _buildPlaceholder(context);
//     }
//   } else {
//     imageWidget = _buildPlaceholder(context);
//   }

//   return GestureDetector(
//     onTap: () {
//       callback();
//     },
//     child: Container(
//       height: sS(context).cH(height: 130),
//       width: sS(context).cW(width: 358),
//       padding: EdgeInsets.symmetric(
//         horizontal: sS(context).cW(width: 8),
//         vertical: sS(context).cH(height: 10),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: backgroundColor,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           if (isFirstItem)
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // SizedBox(
//                 //   width: sS(context).cW(width: 20),
//                 //   height: sS(context).cH(height: 20),
//                 //   // child: Image.asset(icon),
//                 //   child: imageWidget,
//                 // ),
//                 // const S(h: 8),
//                 GeneralTextDisplay(
//                   additionalText,
//                   AppColors.gray1(),
//                   2,
//                   12,
//                   FontWeight.w400,
//                   "",
//                 ),
//               ],
//             ),
//           const S(w: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: sS(context).cW(width: 25),
//                       height: sS(context).cH(height: 25),
//                       // child: Image.asset(icon),
//                       child: imageWidget,
//                     ),
//                     const S(w: 8),
//                     GeneralTextDisplay(
//                       title,
//                       titleColor,
//                       1,
//                       15,
//                       FontWeight.w500,
//                       title,
//                     ),
//                   ],
//                 ),
//                 const S(h: 8),
//                 GeneralTextDisplay(
//                   subtitle,
//                   AppColors.gray1(),
//                   2,
//                   12,
//                   FontWeight.w400,
//                   "",
//                 ),
//                 const S(h: 8),
//                 Row(
//                   children: [
//                     GeneralTextDisplay(
//                       additionalText,
//                       AppColors.black(),
//                       1,
//                       20,
//                       FontWeight.bold,
//                       "",
//                       letterSpacing: 5.0,
//                     ),
//                     const S(w: 10),
//                     InkWell(
//                       child: GeneralIconDisplay(
//                         Icons.copy_rounded,
//                         AppColors.blue(),
//                         UniqueKey(),
//                         20,
//                       ),
//                       onTap: () {
//                         copyToClipboard(context: context, text: currentOtp);
//                       },
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Container(
//               width: 40,
//               height: 40,
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 16),
//                 child: CountdownWidget(
//                   duration: otpExpiresSeconds!,
//                   generateOtp: generateOtp,
//                   updateOtp: updateOtp,
//                 ),
//               )),
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildPlaceholder(BuildContext context) {
//   return Container(
//     width: sS(context).cW(width: 40),
//     height: sS(context).cH(height: 40),
//     color: Colors.grey,
//     child: const Icon(Icons.image, color: Colors.white),
//   );
// }

Widget quickToolWidget({
  required BuildContext context,
  required String icon,
  required String title,
  required String subtitle,
  required String additionalText,
  required String copiedOtp,
  required Color titleColor,
  required Color backgroundColor,
  required Function callback,
  required int otpExpiresSeconds,
  bool isFirstItem = false,
  required Function() generateOtp,
  required Function(String) updateOtp,
}) {
  // Decode base64 image
  Widget imageWidget;
  if (icon.isNotEmpty) {
    String base64String = icon;
    // Remove data URI scheme prefix if present
    if (base64String.contains(',')) {
      base64String = base64String.split(',')[1];
    }
    try {
      final decodedBytes = base64Decode(base64String);
      imageWidget = Image.memory(
        decodedBytes,
        width: sS(context).cW(width: 25),
        height: sS(context).cH(height: 25),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error displaying image: $error');
          return _buildPlaceholder(context);
        },
      );
    } catch (e) {
      debugPrint('Error decoding base64 image: $e');
      imageWidget = _buildPlaceholder(context);
    }
  } else {
    imageWidget = _buildPlaceholder(context);
  }

  // Insert a tab-sized space between the two groups of three digits
  String formattedAdditionalText = additionalText.replaceFirstMapped(
    RegExp(r'(\d{3})(\d{3})'),
    (Match m) => '${m[1]} ${m[2]}',
  );

  return GestureDetector(
    onTap: () {
      callback();
    },
    child: Container(
      height: sS(context).cH(height: 130),
      width: sS(context).cW(width: 358),
      padding: EdgeInsets.symmetric(
        horizontal: sS(context).cW(width: 8),
        vertical: sS(context).cH(height: 10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isFirstItem)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GeneralTextDisplay(
                  additionalText,
                  AppColors.gray1(),
                  2,
                  12,
                  FontWeight.w400,
                  "",
                ),
              ],
            ),
          const S(w: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: sS(context).cW(width: 25),
                      height: sS(context).cH(height: 25),
                      child: imageWidget,
                    ),
                    const S(w: 8),
                    GeneralTextDisplay(
                      title,
                      titleColor,
                      1,
                      15,
                      FontWeight.w500,
                      title,
                    ),
                  ],
                ),
                const S(h: 8),
                GeneralTextDisplay(
                  subtitle,
                  AppColors.gray1(),
                  2,
                  12,
                  FontWeight.w400,
                  "",
                ),
                const S(h: 8),
                Row(
                  children: [
                    GeneralTextDisplay(
                      formattedAdditionalText,
                      AppColors.black(),
                      1,
                      20,
                      FontWeight.bold,
                      "",
                      letterSpacing: 1.5,
                    ),
                    const S(w: 10),
                    InkWell(
                      child: GeneralIconDisplay(
                        Icons.copy_rounded,
                        AppColors.blue(),
                        UniqueKey(),
                        20,
                      ),
                      onTap: () {
                        copyToClipboard(context: context, text: copiedOtp);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 55,
            height: 55,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CountdownWidget(
                duration: otpExpiresSeconds,
                generateOtp: generateOtp,
                updateOtp: updateOtp,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPlaceholder(BuildContext context) {
  return Container(
    width: sS(context).cW(width: 40),
    height: sS(context).cH(height: 40),
    color: Colors.grey,
    child: const Icon(Icons.image, color: Colors.white),
  );
}
