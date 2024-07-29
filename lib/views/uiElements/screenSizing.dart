import '../../utilities/imports/generalImport.dart';

class ScreenSize {
  final BuildContext? context;
  ScreenSize({this.context});

  // screen height
  double get h => MediaQuery.of(context!).size.height;

  // screen width
  double get w => MediaQuery.of(context!).size.width;

  // size
  Size get s => MediaQuery.of(context!).size;
  // text scale factor
  double get tsf => MediaQuery.of(context!).textScaleFactor;

  // calculated height
  double cH({double? height}) =>
      MediaQuery.of(context!).size.height * (height! / 844);
  // calculated width
  double cW({double? width}) =>
      MediaQuery.of(context!).size.width * (width! / 390);
}
