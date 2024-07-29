import 'package:authenticator/utilities/imports/generalImport.dart';

class CheckAppStateViewModel extends BaseModel {
  bool isLoggedIn = false;

  Future<void> checkUserLoginState(BuildContext context) async {
    isLoggedIn = await checkLoginState(context);
    if (isLoggedIn) {
      // clearLoginState();
      // Navigate to home page if user is logged in
      router.goNamed(homeRoute);
      notifyListeners();
    }
  }

  // Existing methods for saving and clearing login state
}
