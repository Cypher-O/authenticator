import '../../../utilities/imports/generalImport.dart';

Widget textFieldWidget(
  BuildContext context, {
  required TextEditingController controller,
  required hintText,
  bool isEmail = false,
  bool isNumber = false,
  bool isPassword = false,
  obscureText = false,
  obscureTextFunction,
}) {
  return SizedBox(
    height: sS(context).cH(height: 48),
    width: sS(context).cW(width: 358),
    child: TextFormField(
      controller: controller,
      cursorColor: AppColors.black(),
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : isNumber
              ? TextInputType.number
              : TextInputType.name,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray3()),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: !isPassword
            ? null
            : GestureDetector(
                onTap: obscureTextFunction,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "Show",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.green()),
                  ),
                ),
              ),
        filled: true,
        fillColor: Theme.of(context).hoverColor,
        hintText: hintText,
        hintStyle:
            TextStyle(color: AppColors.black().withOpacity(0.5), fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      ),
      validator: (String? value) {
        if (value == null) {
          return 'password must not be empty';
        }
        return null;
      },
    ),
  );
}
