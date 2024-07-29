import 'package:authenticator/utilities/imports/generalImport.dart';

Widget addTokenUsernamePasswordModal({
  required BuildContext context,
  required Function(String, String) onLogin,
  required VoidCallback onCancel,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Container(
        width: sS(context).cW(width: 350),
        // height: sS(context).cH(height: 80),
        padding: EdgeInsets.all(sS(context).cW(width: 16)),
        decoration: BoxDecoration(
          color: AppColors.white(),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const S(h: 24),
            GeneralTextDisplay(
              "Username",
              AppColors.black(),
              1,
              12,
              FontWeight.w600,
              "",
              textAlign: TextAlign.left,
            ),
            const S(h: 8),
            FormattedTextFields(
              keyInputType: TextInputType.emailAddress,
              textFieldController: model.usernameController,
              textFieldHint: "Enter your username",
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
            const S(h: 24),
            GeneralTextDisplay(
              "Password",
              AppColors.black(),
              1,
              12,
              FontWeight.w600,
              "",
              textAlign: TextAlign.left,
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
            const S(h: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: buttonNoPositioned(
                    context,
                    text: "Cancel",
                    fontSize: 14,
                    buttonColor: AppColors.gray3Light,
                    navigator: onCancel,
                    radius: 8,
                    width: sS(context).cW(width: 160),
                  ),
                ),
                const S(w: 16),
                Expanded(
                  child: buttonNoPositioned(
                    context,
                    text: "Add",
                    fontSize: 14,
                    buttonColor: AppColors.blueColor,
                    navigator: () => model.addTokenUsernamePassword(context),
                    radius: 8,
                    width: sS(context).cW(width: 160),
                  ),
                ),
              ],
            ),
            // buttonNoPositioned(
            //   context,
            //   text: "Add token",
            //   fontSize: 16,
            //   buttonColor: AppColors.blueColor,
            //   navigator: () => model.addTokenUsernamePassword(context),
            //   // onLogin(usernameController.text, passwordController.text),
            //   radius: 8,
            //   width: sS(context).cW(width: 348),
            // ),
          ],
        ),
      ),
    ),
  );
}
