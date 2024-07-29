import 'package:authenticator/utilities/imports/generalImport.dart';

class BaseModel extends BaseViewModel {
  // for showing error text under text fields
  showErrorText(
      {required String text,
      required bool errorBool,
      TextAlign textAlign = TextAlign.left,
      double lineLength = 1.0}) {
    if (errorBool == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          S(
            h: 20 * lineLength,
            w: 343,
            child: GeneralTextDisplay(
                text, AppColors.red(), 6, 12, FontWeight.w400, 'email',
                textAlign: textAlign),
          ),
          const S(h: 4),
        ],
      );
    } else {
      return const S();
    }
  }

  //remove whatever focus is in place
  void clearFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    // if (currentFocus.hasPrimaryFocus) {
    //   currentFocus.unfocus();
    // }
    currentFocus.unfocus();
    notifyListeners();
  }

  Future<void> initializeUpdateCheck(BuildContext context) async {
    if (Platform.isAndroid) {
      UpdateCheckViewModel().checkForUpdate(context);
      debugPrint("Update check method executed for Android");
    }
  }

  Future<bool> checkLoginState(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint("I am here in checkloginstate");
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> saveLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint("I am here in saveloginstate");
    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> clearLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  Future<void> clearQuickTools() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('quickTools');
  }

Future<void> saveQuickTools(List<QuickToolData> tools) async {
  final prefs = await SharedPreferences.getInstance();
  final List<dynamic> existingToolsJson =
      json.decode(prefs.getString('quickTools') ?? '[]');
  List<QuickToolData> existingTools =
      existingToolsJson.map((item) => QuickToolData.fromJson(item)).toList();

  // Track existing usernames to avoid duplicates
  Set<String> existingUsernames =
      existingTools.map((tool) => tool.subtitle ?? '').toSet();

  // Iterate through new tools to add/update
  for (var newTool in tools) {
    // Check if there is already a tool with the same username
    if (existingUsernames.contains(newTool.subtitle)) {
      // Update existing tool if found (though typically you would update based on a unique key, not username)
      int existingIndex =
          existingTools.indexWhere((tool) => tool.subtitle == newTool.subtitle);
      if (existingIndex != -1) {
        existingTools[existingIndex] = newTool;
      }
    } else {
      // Add new tool if not found
      existingTools.add(newTool);
      existingUsernames.add(newTool.subtitle ?? '');
    }
  }

  // Encode and save the updated list
  final quickToolsJson =
      json.encode(existingTools.map((tool) => tool.toJson()).toList());
  await prefs.setString('quickTools', quickToolsJson);
}


//   Future<void> saveQuickTools(List<QuickToolData> tools) async {
//   final prefs = await SharedPreferences.getInstance();
//   final List<dynamic> existingToolsJson = json.decode(prefs.getString('quickTools') ?? '[]');
//   final List<QuickToolData> existingTools = existingToolsJson.map((item) => QuickToolData.fromJson(item)).toList();

//   // Append new tools to existing tools list
//   existingTools.addAll(tools);

//   final quickToolsJson = json.encode(existingTools.map((tool) => tool.toJson()).toList());
//   await prefs.setString('quickTools', quickToolsJson);
// }

  //For displaying appropriate message
  String formatErrorMessage(message) {
    if (message == null) {
      return undefinedError;
    } else {
      if (message is String) {
        return message;
      } else {
        List<String> errorMessages = [];
        message.values.forEach((errorList) {
          errorMessages.addAll(errorList.cast<String>());
        });
        return errorMessages[0];
      }
    }
  }
}
