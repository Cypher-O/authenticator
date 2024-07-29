import 'package:authenticator/utilities/imports/generalImport.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onViewModelReady: (model) async {},
      disposeViewModel: false,
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: BaseUi(
          children: [
            rowPositioned(
              top: 70,
              left: 16,
              right: 16,
              child: GeneralTextDisplay(
                "Hello There!",
                AppColors.black(),
                1,
                20,
                FontWeight.bold,
                "Hello There!",
              ),
            ),
            rowPositioned(
              top: 130,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: sS(context).cW(width: 16)),
                width: sS(context).w,
                child: const GeneralTextDisplay(
                  "Please use your username and\npassword to sign in",
                  AppColors.gray3Light,
                  2,
                  14,
                  FontWeight.w400,
                  "",
                ),
              ),
            ),
            rowPositioned(
              child: SizedBox(
                height: ScreenSize(context: context).cH(height: 700),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const S(h: 70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GeneralTextDisplay(
                            "Username",
                            AppColors.black(),
                            1,
                            12,
                            FontWeight.w600,
                            "",
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      const S(
                        h: 8,
                      ),
                      FormattedTextFields(
                        keyInputType: TextInputType.emailAddress,
                        textFieldController: model.usernameController,
                        textFieldHint: "Lincolnshire",
                        noBorder: true,
                        autoFocus: false,
                        inputFormatters: const [],
                        onChangedFunction: () {
                          model.onChangedFunctionUserName();
                        },
                        errorTextActive: model.userNameError,
                        focusNode: model.userNameFocusNode,
                      ),
                      const S(h: 8),
                      model.showErrorText(
                          lineLength: 1,
                          text: model.usernameController.text.isEmpty
                              ? 'Empty Field, enter username!'
                              : !isValidUserName(
                                  model.usernameController.text.trim(),
                                )
                                  ? 'Invalid username, Please enter a valid username'
                                  : "",
                          errorBool: model.userNameError),
                      const S(h: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GeneralTextDisplay(
                            "Password",
                            AppColors.black(),
                            1,
                            12,
                            FontWeight.w600,
                            "",
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      const S(h: 8),
                      FormattedTextFields(
                        keyInputType: TextInputType.text,
                        textFieldController: model.passwordController,
                        textFieldHint: "Enter your password",
                        noBorder: true,
                        autoFocus: false,
                        obscureText: model.obscureText,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            model.obscureTextFunction();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GeneralIconDisplay(
                                model.obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                AppColors.black(),
                                UniqueKey(),
                                18,
                              ),
                            ],
                          ),
                        ),
                        inputFormatters: const [],
                        onChangedFunction: () {
                          model.onChangedFunctionPassword();
                        },
                        errorTextActive: model.passwordError,
                        focusNode: model.passwordFocusNode,
                      ),
                      const S(h: 12),
                      model.showErrorText(
                          lineLength: 2,
                          text: model.passwordController.text.isEmpty
                              ? 'Empty Field, enter password!'
                              : !isValidPassword(
                                  model.passwordController.text.trim(),
                                )
                                  ? 'Invalid password, Length must be more than 12'
                                  : "",
                          errorBool: model.passwordError),
                      const S(h: 48),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          buttonNoPositioned(
                            context,
                            text: "Login",
                            fontSize: 16,
                            buttonColor: AppColors.blueColor,
                            navigator: () {
                              model.login(context);
                            },
                            radius: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              top: 140,
              left: 16,
              right: 16,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: sS(context).cH(height: 100),
                  right: sS(context).cW(
                    width: 16,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    model.qrCodeLogin(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.blue(),
                    radius: sS(context).cH(height: 28),
                    child: const Icon(
                      Icons.qr_code_scanner_rounded,
                      color: AppColors.whiteLight,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
