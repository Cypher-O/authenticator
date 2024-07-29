import 'package:authenticator/utilities/imports/generalImport.dart';

class LoginViewModel extends BaseModel {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  bool loggedIn = false;

  bool get obscureText => _obscureText;

  void obscureTextFunction() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  bool userNameError = false;
  bool passwordError = false;

  // focus node
  FocusNode userNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  onChangedFunctionUserName() {
    userNameFocusNode.addListener(() {
      if (userNameFocusNode.hasFocus == false) {
        userNameError = false;
        notifyListeners();
      }
    });

    if (isValidUserName(usernameController.text.trim())) {
      userNameError = false;
      // String username = usernameController.text.trim();
      notifyListeners();
    } else {
      userNameError = true;
      notifyListeners();
    }
  }

  // on change password function
  onChangedFunctionPassword() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus == false) {
        passwordError = false;
        notifyListeners();
      }
    });
    if (isValidPassword(passwordController.text.trim())) {
      passwordError = false;
      notifyListeners();
    } else {
      passwordError = true;
      notifyListeners();
    }
  }

  Future<bool> _validateForm() async {
    if (!isValidUserName(usernameController.text.trim())) {
      userNameError = true;
      notifyListeners();
      userNameFocusNode.requestFocus();
      return false;
    } else if (!isValidPassword(passwordController.text.trim())) {
      passwordError = true;
      notifyListeners();
      passwordFocusNode.requestFocus();
      return false;
    } else {
      return true;
    }
  }

  login(BuildContext context) async {
    clearFocus(context);
    bool validated = await _validateForm();
    if (validated) {
      runFunctionForApi(
        context,
        functionToRunAfterService: (value) async {
          if (value is ResponseModel) {
            if (value.code == 0) {
              debugPrint('USER LOGIN SUCCESSFULLY');
              responseModelBucket = value;
              companyBase64Image = responseModelBucket!.data.customerLogo;
              otpExpiresSeconds = responseModelBucket!.data.otpExpiresSeconds;
              companyName = responseModelBucket!.data.companyName;
              username = responseModelBucket!.data.username;
              currentOtp = responseModelBucket!.data.otp ?? "";

              await saveLoginState();
              await saveQuickTools([
                QuickToolData(
                  icon: companyBase64Image,
                  title: companyName,
                  subtitle: username,
                  currentOtp: currentOtp,
                  otpExpiresSeconds: otpExpiresSeconds!,
                )
              ]);
              debugPrint("Saved login state and QuickTool data successfully");
              debugPrint("Saved login state after login successfully");
              context.goNamed(homeRoute);
              notifyListeners();
            }
            else {
              loaderWithClose(context,
                  text: formatErrorMessage(value.message), removePage: false);
              debugPrint("Message ${value.message}");
            }
          } else {
            loaderWithClose(context,
                text: formatErrorMessage(value['message']), removePage: false);
            debugPrint("Message ${value['message']}");
          }
        },
        functionToRunService: verifyLoginService(
          username: usernameController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  qrCodeLogin(BuildContext context) async {
    context.goNamed(qrCodeRoute);
  }
}
