// this is a ant for all the colors used int application
// general color scheme
import '../imports/generalImport.dart';

const Color transparent = Colors.transparent;
const Color shadow = Color.fromRGBO(0, 0, 0, 0.1);

// transaction map
Map<String, List> transactionStatus = {
  '1': ["Failed", Colors.red],
  "2": ["Successful", Colors.green],
  '3': ['Declined', Colors.black],
  "4": ["Queued", Colors.yellow]
};

class AppColors {
  static const Color blueColor = Color(0xFF275bff);
  static const Color greyedOut = Color(0xFFf2f1f7);
  // static const white = Colors.white;
  // static const black = Colors.black;
  // static const grey = Colors.grey;
  // static const red = Colors.red;
  // static const transparent = Colors.transparent;
  // static const green = Colors.green;

  // Light theme colors
  static const Color whiteLight = Colors.white;
  static const Color blackLight = Colors.black;
  static const Color greyLight = Colors.grey;
  static const Color redLight = Colors.red;
  static const Color yellowLight = Colors.yellow;
  static const Color dimYellow = Colors.amber;
  static const Color greenLight = Color.fromRGBO(13, 167, 94, 1);
  static const Color goldLight = Color.fromRGBO(241, 135, 57, 1);

  static const Color darkGreenLight = Color.fromRGBO(2, 137, 75, 1);
  static const Color lightGreenLight = Color.fromRGBO(235, 246, 238, 1);
  static const Color blueLight = Color.fromRGBO(79, 82, 166, 1);
  static const Color gray1Light = Color.fromRGBO(51, 51, 51, 1);
  static const Color gray2Light = Color.fromRGBO(130, 130, 130, 1);
  static const Color gray3Light = Color.fromRGBO(128, 128, 128, 1);
  static const Color gray4Light = Color.fromRGBO(189, 189, 189, 1);
  static const Color gray5Light = Color.fromRGBO(224, 224, 224, 1);
  static const Color gray6Light = Color.fromRGBO(242, 242, 242, 1);
  static const Color orangeLight = Color.fromRGBO(241, 135, 57, 1);
  static const Color brownLight = Color.fromRGBO(183, 92, 26, 1);
  static const Color lightBrownLight = Color.fromRGBO(241, 135, 57, 0.15);
  static const Color paleBlueLight = Color.fromRGBO(235, 246, 238, 1);
  static const Color deepBlueLight = Color.fromRGBO(0, 57, 142, 1);
  static const Color lightBlueLight = Color.fromRGBO(0, 57, 142, 0.1);
  static const Color lightPinkLight = Color.fromRGBO(252, 221, 236, 0.35);
  static const Color pinkLight = Color.fromRGBO(239, 93, 168, 1);
  static const Color purpleLight = Color.fromRGBO(125, 8, 144, 1);
  static const Color lightPurpleLight = Color.fromRGBO(125, 8, 144, 0.1);

  // Dark theme colors
  static const Color whiteDark = Colors.black;
  static const Color blackDark = Colors.white;
  static const Color greyDark = Color(0xFFE0E0E0);

  static const Color redDark = Colors.red;
  static const Color yellowDark = Color(0xFFDAA520);
  static const Color greenDark = Color.fromRGBO(13, 167, 94, 1);
  static const Color goldDark = Color.fromRGBO(241, 135, 57, 1);

  static const Color darkGreenDark = Color.fromRGBO(2, 137, 75, 1);
  static const Color lightGreenDark = Color.fromRGBO(13, 167, 94, 0.1);
  static const Color blueDark = Color.fromRGBO(79, 82, 166, 1);
  static const Color gray1Dark = Color.fromRGBO(204, 204, 204, 1);
  static const Color gray2Dark = Color.fromRGBO(125, 125, 125, 1);
  static const Color gray3Dark = Color.fromRGBO(127, 127, 127, 1);
  static const Color gray4Dark = Color.fromRGBO(66, 66, 66, 1);
  static const Color gray5Dark = Color.fromRGBO(31, 31, 31, 1);
  static const Color gray6Dark = Color.fromRGBO(13, 13, 13, 1);
  static const Color orangeDark = Color.fromRGBO(241, 135, 57, 1);
  static const Color brownDark = Color.fromRGBO(183, 92, 26, 1);
  static const Color lightBrownDark = Color.fromRGBO(241, 135, 57, 0.15);
  static const Color paleBlueDark = Color.fromRGBO(0, 57, 142, 1);
  static const Color deepBlueDark = Color.fromRGBO(0, 57, 142, 1);
  static const Color lightBlueDark = Color.fromRGBO(0, 57, 142, 0.1);
  static const Color lightPinkDark = Color.fromRGBO(252, 221, 236, 0.35);
  static const Color pinkDark = Color.fromRGBO(239, 93, 168, 1);
  static const Color purpleDark = Color.fromRGBO(125, 8, 144, 1);
  static const Color lightPurpleDark = Color.fromRGBO(125, 8, 144, 0.1);

  // Method to get the appropriate color based on the current theme
  static Color white() {
    // final brightness = Theme.of(context).brightness;
    return isDarkModeBucket ? whiteDark : whiteLight;
  }

  static Color AlwaysWhite() {
    return isDarkModeBucket ? blackDark : whiteLight;
  }

  static Color black() {
    return isDarkModeBucket ? blackDark : blackLight;
  }

  static Color grey() {
    return isDarkModeBucket ? greyDark : greyLight;
  }

  static Color red() {
    return isDarkModeBucket ? redDark : redLight;
  }

  static Color yellow() {
    return isDarkModeBucket ? yellowDark : yellowLight;
  }

  static Color green() {
    return isDarkModeBucket ? greenDark : greenLight;
  }

  static Color gold() {
    return isDarkModeBucket ? goldDark : goldLight;
  }

  static Color darkGreen() {
    return isDarkModeBucket ? darkGreenDark : darkGreenLight;
  }

  static Color lightGreen() {
    return isDarkModeBucket ? lightGreenDark : lightGreenLight;
  }

  static Color blue() {
    return isDarkModeBucket ? blueColor : blueColor;
  }

  static Color gray1() {
    return isDarkModeBucket ? gray1Dark : gray1Light;
  }

  static Color gray2() {
    return isDarkModeBucket ? gray2Dark : gray2Light;
  }

  static Color gray3() {
    return isDarkModeBucket ? gray3Dark : gray3Light;
  }

  static Color gray4() {
    return isDarkModeBucket ? gray4Dark : gray4Light;
  }

  static Color gray5() {
    return isDarkModeBucket ? gray5Dark : gray5Light;
  }

  static Color greyedOutColor() {
    return isDarkModeBucket ? greyedOut : greyedOut;
  }

  static Color gray6() {
    return isDarkModeBucket ? gray6Dark : gray6Light;
  }

  static Color orange() {
    return isDarkModeBucket ? orangeDark : orangeLight;
  }

  static Color brown() {
    return isDarkModeBucket ? brownDark : brownLight;
  }

  static Color lightBrown() {
    return isDarkModeBucket ? lightBrownDark : lightBrownLight;
  }

  static Color paleBlue() {
    return isDarkModeBucket ? paleBlueDark : paleBlueLight;
  }

  static Color deepBlue() {
    return isDarkModeBucket ? deepBlueDark : deepBlueLight;
  }

  static Color lightBlue() {
    return isDarkModeBucket ? lightBlueDark : lightBlueLight;
  }

  static Color lightPink() {
    return isDarkModeBucket ? lightPinkDark : lightPinkLight;
  }

  static Color pink() {
    return isDarkModeBucket ? pinkDark : pinkLight;
  }

  static Color purple() {
    return isDarkModeBucket ? purpleDark : purpleLight;
  }

  static Color lightPurple() {
    return isDarkModeBucket ? lightPurpleDark : lightPurpleLight;
  }
}
