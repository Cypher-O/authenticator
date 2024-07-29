// this is a sized box class

import 'package:authenticator/utilities/imports/generalImport.dart';

class S extends StatelessWidget {
  // h is height, w is width
  final double? h, w;
  final Widget? child;

  const S({super.key, this.h = 0, this.w = 0, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sS(context).cW(width: w),
      height: sS(context).cH(height: h),
      child: child ?? Container(),
    );
  }
}
