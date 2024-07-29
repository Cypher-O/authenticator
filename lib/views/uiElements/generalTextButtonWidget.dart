import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final Function onPressed;
  final Color overlayColor;
  final Widget child;

  const TextButtonWidget({super.key, 
    required this.onPressed,
    required this.child,
    required this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(overlayColor.withOpacity(0.25)),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          onPressed();
        },
        child: child);
  }
}
