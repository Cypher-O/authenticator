import 'package:authenticator/utilities/imports/generalImport.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return ViewModelBuilder<CheckAppStateViewModel>.reactive(
      viewModelBuilder: () => CheckAppStateViewModel(),
      onViewModelReady: (model) async {
        await model.checkUserLoginState(context);
        // model.clearLoginState();
        // model.clearQuickTools();
      },
      builder: (context, model, child) {
        return MaterialApp.router(
          title: 'Authenticator',
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primarySwatch: MaterialColor(0xFF0DA75E, primarySwatchColor),
          ),
        );
      },
    );
  }
}
