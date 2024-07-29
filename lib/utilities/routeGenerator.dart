import 'package:authenticator/utilities/imports/generalImport.dart';

// final navigatorKey = GlobalKey<NavigatorState>();
// final router = GoRouter(
//   navigatorKey: navigatorKey,
//   debugLogDiagnostics: false,
//   initialLocation: '/login',
//   routes: [
//     GoRoute(
//       name: mainAppRoute,
//       path: '/mainApp',
//       redirect: (BuildContext context, GoRouterState state) async {},
//     ),
//     GoRoute(
//       name: homeRoute,
//       path: '/home',
//       pageBuilder: (context, state) =>
//           MaterialPage<void>(key: state.pageKey, child: const Home()),
//       routes: [],
//     ),
//     GoRoute(
//       name: loginRoute,
//       path: '/login',
//       pageBuilder: (context, state) =>
//           MaterialPage<void>(key: state.pageKey, child: const Login()),
//       routes: [
//         GoRoute(
//           name: qrCodeRoute,
//           path: 'qrCode',
//           pageBuilder: (context, state) =>
//               MaterialPage<void>(key: state.pageKey, child: const QrCode()),
//         ),
//       ],
//     ),
//   ],
// );

final navigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  navigatorKey: navigatorKey,
  debugLogDiagnostics: false,
  initialLocation: '/login', // Initial route to start with
  routes: [
    GoRoute(
      name: mainAppRoute,
      path: '/mainApp',
      redirect: (BuildContext context, GoRouterState state) async {},
    ),
    GoRoute(
      name: homeRoute,
      path: '/home',
      pageBuilder: (context, state) =>
          MaterialPage<void>(key: state.pageKey, child: const Home()),
      routes: const [],
    ),
    GoRoute(
      name: loginRoute,
      path: '/login',
      pageBuilder: (context, state) =>
          MaterialPage<void>(key: state.pageKey, child: const Login()),
      routes: [
        GoRoute(
          name: qrCodeRoute,
          path: 'qrCode',
          pageBuilder: (context, state) =>
              MaterialPage<void>(key: state.pageKey, child: const QrCode()),
        ),
      ],
    ),
  ],
);
