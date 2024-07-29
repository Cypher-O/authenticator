import 'package:authenticator/utilities/imports/generalImport.dart';

class GeneralIconDisplay extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Key iconKey;

  const GeneralIconDisplay(this.icon, this.iconColor, this.iconKey, this.iconSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      key: iconKey,
      size: sS(context).cH(height: iconSize),
      color: iconColor,
    );
  }
}
