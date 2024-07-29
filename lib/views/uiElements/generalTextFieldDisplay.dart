// this textField is for otp textField
import 'package:authenticator/utilities/imports/generalImport.dart';

class PinTextField extends StatelessWidget {
  final TextInputType keyInputType;
  final TextEditingController textFieldController;
  final int textFieldLineSpan;
  final String textFieldLabel;
  final String textFieldHint;
  final dynamic functionValue;
  final double height;
  final double width;
  final Color containerColor;
  final bool greyBackground;
  final FocusNode focus;
  final Function onFieldSubmitted;
  final int maxIndex;
  final bool? errorTextActive;

  const PinTextField(
      this.keyInputType,
      this.textFieldController,
      this.textFieldLabel,
      this.textFieldHint,
      this.functionValue,
      this.textFieldLineSpan,
      this.height,
      this.width,
      this.containerColor,
      this.greyBackground,
      this.focus,
      this.onFieldSubmitted,
      this.maxIndex,
      {super.key, this.errorTextActive});

  @override
  Widget build(BuildContext context) {
    Size dynamicSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: sS(context).cH(height: height),
      width: sS(context).cW(width: width),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.height * (4 / 800)),
      ),
      alignment: Alignment.center,
      child: Align(
        alignment: Alignment.center,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.bottom,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          cursorColor: AppColors.blue(),
          keyboardType: keyInputType,
          controller: textFieldController,
          maxLines: textFieldLineSpan,
          focusNode: focus,
          textInputAction:
              maxIndex == 4 ? TextInputAction.done : TextInputAction.done,
          onChanged: (change) {
            onFieldSubmitted();
          },
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: AppColors.blue(),
                  fontSize: orientation == Orientation.portrait
                      ? sS(context).cH(height: 30)
                      : dynamicSize.width * (16 / 800),
                  fontWeight: FontWeight.w500)),
          autocorrect: true,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: textFieldLabel,
              hintStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * (30 / 800)
                          : dynamicSize.width * (16 / 800),
                      color: AppColors.blue(),
                      fontWeight: FontWeight.w500)),
              hintText: textFieldHint,
              labelStyle: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      fontSize: orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * (15 / 800)
                          : dynamicSize.width * (16 / 800),
                      color: const Color.fromRGBO(186, 186, 186, 1.0),
                      fontWeight: FontWeight.w500)),
              contentPadding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * (15 / 390),
                  MediaQuery.of(context).size.height * (5 / 844),
                  MediaQuery.of(context).size.width * (2 / 390),
                  MediaQuery.of(context).size.height * (5 / 844)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.grey(),
                      width: 1.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(
                    orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * (4 / 800)
                        : dynamicSize.width * (4 / 800),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: errorTextActive == true
                          ? AppColors.red()
                          : AppColors.blue(),
                      width: 1.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(
                    orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * (4 / 800)
                        : dynamicSize.width * (4 / 800),
                  ))),
        ),
      ),
    );
  }
}

class FormattedTextFields extends StatelessWidget {
  final TextInputType keyInputType;
  final TextInputAction? textInputAction;
  final TextEditingController textFieldController;
  final int? textFieldMinLineSpan, textFieldLineSpan, maxLength;
  final String? textFieldHint;
  final double? height, width, textFont, hintFont, labelFont, borderRadius;
  final Color? containerColor,
      cursorColor,
      hintColor,
      labelColor,
      outLineBorderColor,
      focusBorderColor;
  final bool? noBorder, autoFocus, obscureText, readOnly;
  final Function? onChangedFunction, onTap;
  final List<TextInputFormatter> inputFormatters;
  final bool errorTextActive;
  final FocusNode? focusNode;
  final Widget? prefixIcon, suffixIcon;
  final Widget? prefix;
  final FontWeight? textFontWeight, hintFontWeight, labelFontWeight;
  final FloatingLabelBehavior? labelBehaviour;
  final bool? enableInteractiveSelection;
  final Alignment? align;
  final double? cursorHeight;
  final TextAlign? textAlign;
  final EdgeInsets? contentPadding;

  const FormattedTextFields({
    super.key,
    required this.keyInputType,
    required this.textFieldController,
    required this.textFieldHint,
    this.textFieldLineSpan,
    this.height,
    this.width,
    this.textFieldMinLineSpan,
    this.containerColor,
    this.enableInteractiveSelection,
    required this.noBorder,
    this.autoFocus,
    this.textInputAction,
    required this.inputFormatters,
    required this.onChangedFunction,
    required this.errorTextActive,
    required this.focusNode,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.textFont,
    this.hintFont,
    this.labelFont,
    this.cursorHeight,
    this.borderRadius,
    this.cursorColor,
    this.hintColor,
    this.labelColor,
    this.outLineBorderColor,
    this.focusBorderColor,
    this.textFontWeight,
    this.hintFontWeight,
    this.labelFontWeight,
    this.obscureText,
    this.labelBehaviour,
    this.maxLength,
    this.align,
    this.onTap,
    this.readOnly,
    this.textAlign,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sS(context).cH(height: height ?? 48),
      width: sS(context).cW(width: width ?? 358),
      decoration: BoxDecoration(
        color: containerColor ?? AppColors.gray6(),
        borderRadius:
            BorderRadius.circular(sS(context).cW(width: borderRadius ?? 8)),
      ),
      alignment: align ?? Alignment.center,
      child: TextFormField(
        focusNode: focusNode,
        onTap: () {
          if (onTap != null) onTap!();
        },
        onChanged: (changed) {
          onChangedFunction!();
        }, // this function to validate the
        // text field as the user types in it
        autofocus: autoFocus ?? false,
        enabled: readOnly ?? true,
        // enabled: readOnly != null ? !readOnly! : true,
        cursorHeight: cursorHeight,
        cursorColor: cursorColor ?? AppColors.gray4(),
        textInputAction: textInputAction ?? TextInputAction.done,
        keyboardType: keyInputType,
        obscureText: obscureText ?? false,
        obscuringCharacter: '*',
        controller: textFieldController,
        textAlign: textAlign ?? TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        enableInteractiveSelection: enableInteractiveSelection,
        minLines: textFieldMinLineSpan,
        maxLines: textFieldLineSpan ?? 1,
        inputFormatters: inputFormatters,

        style: GoogleFonts.inter(
            textStyle: TextStyle(
                color: AppColors.black(),
                fontSize: textFont ?? 15,
                fontWeight: textFontWeight ?? FontWeight.w500)),
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.greyedOutColor(),
            prefix: prefix,
            hintStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                    fontSize: sS(context).cH(height: hintFont ?? 14),
                    color: hintColor ?? AppColors.gray3(),
                    fontWeight: hintFontWeight ?? FontWeight.normal)),
            hintText: textFieldHint,
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: contentPadding ??
                EdgeInsets.fromLTRB(sS(context).cW(width: 16),
                    sS(context).cH(height: 12), 0, 0),
            disabledBorder: OutlineInputBorder(
                borderSide: noBorder == true
                    ? BorderSide.none
                    : BorderSide(
                        color: outLineBorderColor ?? AppColors.gray5(),
                        width: 1.0,
                        style: noBorder == true
                            ? BorderStyle.none
                            : BorderStyle.solid),
                borderRadius: BorderRadius.circular(
                    sS(context).cW(width: borderRadius ?? 4))),
            enabledBorder: OutlineInputBorder(
                borderSide: noBorder == true
                    ? BorderSide.none
                    : BorderSide(
                        color: outLineBorderColor ?? AppColors.gray5(),
                        width: 1.0,
                        style: noBorder == true
                            ? BorderStyle.none
                            : BorderStyle.solid),
                borderRadius: BorderRadius.circular(
                    sS(context).cW(width: borderRadius ?? 8))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: errorTextActive == true
                        ? AppColors.red()
                        : focusBorderColor ?? AppColors.gray5(),
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(
                    sS(context).cW(width: borderRadius ?? 8)))),
      ),
    );
  }
}

class ReadOnlyFormattedTextFields extends StatelessWidget {
  final TextInputType keyInputType;
  final TextInputAction? textInputAction;
  final TextEditingController textFieldController;
  final int? textFieldMinLineSpan, textFieldLineSpan, maxLength;
  final String? textFieldHint;
  final double? height, width, textFont, hintFont, labelFont, borderRadius;
  final Color? containerColor,
      cursorColor,
      hintColor,
      labelColor,
      outLineBorderColor,
      focusBorderColor;
  final bool? noBorder, autoFocus, obscureText, readOnly;
  final Function? onChangedFunction, onTap;
  final List<TextInputFormatter> inputFormatters;
  final bool errorTextActive;
  final FocusNode? focusNode;
  final Widget? prefixIcon, suffixIcon;
  final Widget? prefix;
  final FontWeight? textFontWeight, hintFontWeight, labelFontWeight;
  final FloatingLabelBehavior? labelBehaviour;
  final bool? enableInteractiveSelection;
  final Alignment? align;
  final double? cursorHeight;
  final TextAlign? textAlign;
  final EdgeInsets? contentPadding;

  const ReadOnlyFormattedTextFields({
    super.key,
    required this.keyInputType,
    required this.textFieldController,
    required this.textFieldHint,
    this.textFieldLineSpan,
    this.height,
    this.width,
    this.textFieldMinLineSpan,
    this.containerColor,
    this.enableInteractiveSelection,
    required this.noBorder,
    this.autoFocus,
    this.textInputAction,
    required this.inputFormatters,
    required this.onChangedFunction,
    required this.errorTextActive,
    required this.focusNode,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.textFont,
    this.hintFont,
    this.labelFont,
    this.cursorHeight,
    this.borderRadius,
    this.cursorColor,
    this.hintColor,
    this.labelColor,
    this.outLineBorderColor,
    this.focusBorderColor,
    this.textFontWeight,
    this.hintFontWeight,
    this.labelFontWeight,
    this.obscureText,
    this.labelBehaviour,
    this.maxLength,
    this.align,
    this.onTap,
    this.readOnly,
    this.textAlign,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sS(context).cH(height: height ?? 48),
      width: sS(context).cW(width: width ?? 358),
      decoration: BoxDecoration(
        color: containerColor ?? AppColors.gray6(),
        borderRadius:
            BorderRadius.circular(sS(context).cW(width: borderRadius ?? 8)),
      ),
      alignment: align ?? Alignment.center,
      child: TextFormField(
        focusNode: focusNode,
        onTap: () {
          if (onTap != null) onTap!();
        },
        onChanged: (changed) {
          onChangedFunction!();
        }, // this function to validate the
        // text field as the user types in it
        autofocus: autoFocus ?? false,
        // // enabled: readOnly ?? true,
        // enabled: (readOnly != null ? !readOnly! : true) &&
        //     textFieldController.text.isEmpty,
        enabled: readOnly != null ? !readOnly! : true,
        cursorHeight: cursorHeight,
        cursorColor: cursorColor ?? AppColors.gray4(),
        textInputAction: textInputAction ?? TextInputAction.done,
        keyboardType: keyInputType,
        obscureText: obscureText ?? false,
        obscuringCharacter: '*',
        controller: textFieldController,
        textAlign: textAlign ?? TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        enableInteractiveSelection: enableInteractiveSelection,
        minLines: textFieldMinLineSpan,

        maxLines: textFieldLineSpan ?? 1,
        inputFormatters: inputFormatters,

        style: GoogleFonts.inter(
            textStyle: TextStyle(
                color: AppColors.black(),
                fontSize: textFont ?? 15,
                fontWeight: textFontWeight ?? FontWeight.w500)),
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.gray6(),
            prefix: prefix,
            hintStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                    fontSize: sS(context).cH(height: hintFont ?? 14),
                    color: hintColor ?? AppColors.gray3(),
                    fontWeight: hintFontWeight ?? FontWeight.normal)),
            hintText: textFieldHint,
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: contentPadding ??
                EdgeInsets.fromLTRB(sS(context).cW(width: 16),
                    sS(context).cH(height: 12), 0, 0),
            disabledBorder: OutlineInputBorder(
                borderSide: noBorder == true
                    ? BorderSide.none
                    : BorderSide(
                        color: outLineBorderColor ?? AppColors.gray5(),
                        width: 1.0,
                        style: noBorder == true
                            ? BorderStyle.none
                            : BorderStyle.solid),
                borderRadius: BorderRadius.circular(
                    sS(context).cW(width: borderRadius ?? 4))),
            enabledBorder: OutlineInputBorder(
                borderSide: noBorder == true
                    ? BorderSide.none
                    : BorderSide(
                        color: outLineBorderColor ?? AppColors.gray5(),
                        width: 1.0,
                        style: noBorder == true
                            ? BorderStyle.none
                            : BorderStyle.solid),
                borderRadius: BorderRadius.circular(
                    sS(context).cW(width: borderRadius ?? 8))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: errorTextActive == true
                        ? AppColors.red()
                        : focusBorderColor ?? AppColors.gray5(),
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(
                    sS(context).cW(width: borderRadius ?? 8)))),
      ),
    );
  }
}

class UserDetailsFormattedTextFields extends StatelessWidget {
  final TextInputType keyInputType;
  final TextInputAction? textInputAction;
  final TextEditingController textFieldController;
  final int? textFieldMinLineSpan, textFieldLineSpan, maxLength;
  final String? textFieldHint;
  final double? height, width, textFont, hintFont, labelFont, borderRadius;
  final Color? containerColor,
      cursorColor,
      hintColor,
      labelColor,
      outLineBorderColor,
      focusBorderColor;
  final bool? noBorder, autoFocus, obscureText, readOnly;
  final Function? onChangedFunction, onTap;
  final List<TextInputFormatter> inputFormatters;
  final bool errorTextActive;
  final FocusNode? focusNode;
  final Widget? prefixIcon, suffixIcon;
  final Widget? prefix;
  final FontWeight? textFontWeight, hintFontWeight, labelFontWeight;
  final FloatingLabelBehavior? labelBehaviour;
  final bool? enableInteractiveSelection;
  final Alignment? align;
  final double? cursorHeight;
  final TextAlign? textAlign;
  final EdgeInsets? contentPadding;

  const UserDetailsFormattedTextFields({
    super.key,
    required this.keyInputType,
    required this.textFieldController,
    required this.textFieldHint,
    this.textFieldLineSpan,
    this.height,
    this.width,
    this.textFieldMinLineSpan,
    this.containerColor,
    this.enableInteractiveSelection,
    required this.noBorder,
    this.autoFocus,
    this.textInputAction,
    required this.inputFormatters,
    required this.onChangedFunction,
    required this.errorTextActive,
    required this.focusNode,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.textFont,
    this.hintFont,
    this.labelFont,
    this.cursorHeight,
    this.borderRadius,
    this.cursorColor,
    this.hintColor,
    this.labelColor,
    this.outLineBorderColor,
    this.focusBorderColor,
    this.textFontWeight,
    this.hintFontWeight,
    this.labelFontWeight,
    this.obscureText,
    this.labelBehaviour,
    this.maxLength,
    this.align,
    this.onTap,
    this.readOnly,
    this.textAlign,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sS(context).cH(height: height ?? 48),
      width: sS(context).cW(width: width ?? 358),
      decoration: BoxDecoration(
        color: containerColor ?? AppColors.gray6(),
        borderRadius:
            BorderRadius.circular(sS(context).cW(width: borderRadius ?? 8)),
      ),
      alignment: align ?? Alignment.center,
      child: TextFormField(
        focusNode: focusNode,
        onTap: () {
          if (onTap != null) onTap!();
        },
        onChanged: (changed) {
          onChangedFunction!();
        }, // this function to validate the
        // text field as the user types in it
        autofocus: autoFocus ?? false,
        enabled: readOnly ?? true,
        cursorHeight: cursorHeight,
        cursorColor: cursorColor ?? AppColors.gray4(),
        textInputAction: textInputAction ?? TextInputAction.done,
        keyboardType: keyInputType,
        obscureText: obscureText ?? false,
        obscuringCharacter: '*',
        controller: textFieldController,
        textAlign: textAlign ?? TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        enableInteractiveSelection: enableInteractiveSelection,
        minLines: textFieldMinLineSpan,
        maxLines: textFieldLineSpan ?? 1,
        inputFormatters: inputFormatters,

        style: GoogleFonts.inter(
            textStyle: TextStyle(
                color: AppColors.gray3(),
                fontSize: textFont ?? 15,
                fontWeight: textFontWeight ?? FontWeight.w500)),
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.gray6(),
            prefix: prefix,
            hintStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                    fontSize: sS(context).cH(height: hintFont ?? 14),
                    color: hintColor ?? AppColors.gray3(),
                    fontWeight: hintFontWeight ?? FontWeight.normal)),
            hintText: textFieldHint,
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: contentPadding ??
                EdgeInsets.fromLTRB(sS(context).cW(width: 16),
                    sS(context).cH(height: 12), 0, 0),
            disabledBorder: OutlineInputBorder(
                borderSide: noBorder == true
                    ? BorderSide.none
                    : BorderSide(
                        color: outLineBorderColor ?? AppColors.gray5(),
                        width: 1.0,
                        style: noBorder == true
                            ? BorderStyle.none
                            : BorderStyle.solid),
                borderRadius: BorderRadius.circular(
                    sS(context).cW(width: borderRadius ?? 4))),
            enabledBorder: OutlineInputBorder(
                borderSide: noBorder == true
                    ? BorderSide.none
                    : BorderSide(
                        color: outLineBorderColor ?? AppColors.gray5(),
                        width: 1.0,
                        style: noBorder == true
                            ? BorderStyle.none
                            : BorderStyle.solid),
                borderRadius: BorderRadius.circular(
                    sS(context).cW(width: borderRadius ?? 8))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: errorTextActive == true
                        ? AppColors.red()
                        : focusBorderColor ?? AppColors.gray5(),
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(
                    sS(context).cW(width: borderRadius ?? 8)))),
      ),
    );
  }
}
