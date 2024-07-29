import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final dynamic onPressed;
  final dynamic color;
  final double width;
  final double height;
  final Widget child;
  final Alignment align;
  final double radius;
  final FocusNode? focusNode;
  final double? noElevation;
  final Color? borderColor;

  const ButtonWidget(this.onPressed, this.color, this.width, this.height, this.child,
      this.align, this.radius,
      {super.key, this.focusNode, this.noElevation, this.borderColor});

  @override
  Widget build(BuildContext context) {
    Size dynamicSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return ElevatedButton(
        focusNode: focusNode ?? FocusNode(),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            elevation: noElevation ?? 4.0,
            alignment: align,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor ?? color),
              borderRadius:
                  BorderRadius.circular(dynamicSize.height * (radius / 844)),
            ),
            fixedSize: Size(
                orientation == Orientation.portrait
                    ? dynamicSize.width * (width / 390)
                    : dynamicSize.height * (width / 390),
                orientation == Orientation.landscape
                    ? dynamicSize.width * (height / 844)
                    : dynamicSize.height * (height / 844))),
        child: child);
  }
}
