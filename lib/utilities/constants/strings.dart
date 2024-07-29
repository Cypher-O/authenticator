// constants of string
// screen sizing

import 'package:authenticator/utilities/imports/generalImport.dart';

// instantiate classes
ScreenSize sS(
  BuildContext context,
) =>
    ScreenSize(context: context);

// constant strings
const String tokenKey = 'token';

// error string
const String error = "An error occured";
const String networkError =
    'Unable to process request, check your network and try again later';
const String undefinedError = 'Error occurred, try again later';
const String bvnErrorMessage =
    "Unable to verify BVN at this moment, kindly try again";
const String invalidBaseUrl = 'Unable to access host, invalid base url';
const String invalidAccountNumber =
    'The account number you entered is incorrect, kindly check again';
const String notificationRead = "Notification marked as read";
const String assetImagePlaceHolder = "assets/avatar.jpeg";
const String assetImagePlaceHolderRecipient = "assets/avatar2.png";
const String networkImagePlaceHolder =
    "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250";
const String invalidPassword =
    'Invalid password, Length must be more than 7 and contains lower case, upper case , digit and  symbol';
const String isEmptyString = " must be filled";
const String serviceUnavailableError = "Service provider not available";

// primary swatch color map
final Map<int, Color> primarySwatchColor = {
  50: Colors.green.withOpacity(0.1),
  100: Colors.green.withOpacity(0.2),
  200: Colors.green.withOpacity(0.3),
  300: Colors.green.withOpacity(0.4),
  400: Colors.green.withOpacity(0.5),
  500: Colors.green.withOpacity(0.6),
  600: Colors.green.withOpacity(0.7),
  700: Colors.green.withOpacity(0.8),
  800: Colors.green.withOpacity(0.9),
  900: Colors.green.withOpacity(1.0),
};

// constant sizes
const double hPadding = 16;

//theme strings
const String darkThemeString = 'Dark';
const String lightThemeString = 'Light';
const String systemThemeString = 'System default';

//theme preference keys
const String isDarkModeString = 'isDarkMode'; //for dark mode bool
const String currentThemeString =
    'currentTheme'; //for getting the current settings

//app version to check update for
const String appVersion = "1.0.0";

String? latestVersion;
