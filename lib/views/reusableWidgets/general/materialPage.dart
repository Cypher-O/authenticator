// material page function
import 'package:authenticator/utilities/imports/generalImport.dart';

materialPage(settings, page) {
  return PageTransition(
      type: PageTransitionType.fade,
      settings: settings,
      child: page,
      duration: const Duration(milliseconds: 100));
}
