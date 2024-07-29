import '../../../utilities/imports/generalImport.dart';

slideTransition({LocalKey? key, required Widget page, bool slideUp = false}) {
  return CustomTransitionPage<void>(
    key: key,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: Tween<Offset>(
        begin: slideUp ? const Offset(0, 1) : const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    ),
    transitionDuration: const Duration(milliseconds: 450),
    reverseTransitionDuration: const Duration(milliseconds: 450),
  );
}

fadeTransition({LocalKey? key, required Widget page}) {
  return CustomTransitionPage<void>(
    key: key,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
