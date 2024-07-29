// adding row to adaption Positioned widget
import 'package:authenticator/utilities/imports/generalImport.dart';

Widget rowPositioned(
    {required Widget child, double? left, double? right, required double top}) {
  return AdaptivePositioned(
      Row(
        mainAxisAlignment: left == null && right != null
            ? MainAxisAlignment.end
            : left != null && right == null
                ? MainAxisAlignment.start
                : left == null && right == null
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
        children: [
          child,
        ],
      ),
      left: left ?? 0,
      right: right ?? 0,
      top: top);
}
