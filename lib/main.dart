import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/view/authenticate/onboard/view/on_board_view.dart';

import 'core/constants/app/app_constants.dart';
import 'core/init/lang/language_manager.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'view/authenticate/login/view/login_view.dart';

Future<void> main() async {
  // LocaleManager.preferencesInit();
  await _init();
  runApp(
    EasyLocalization(
      child: const MyApp(),
      supportedLocales: LanguageManager.instance!.supporteedLocales,
      path: ApplicationConstants.LANG_ASSETS_PATH,
      startLocale: LanguageManager.instance!.enLocale,
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginView(),
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance!.navigatorKey,
    );
  }
}
