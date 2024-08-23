import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/application_theme_manager.dart';
import 'package:to_do_app/core/page_route_names.dart';
import 'package:to_do_app/core/route_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/core/setting_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app/services/loading_service.dart';
import 'firebase_options.dart';

void main() async {
  // to make sure every await task is done
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingProvider(),
      child: const MyApp(),
    ),
  );
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingProvider>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'TO DO List',
      debugShowCheckedModeBanner: false,
      locale: Locale(provider.curLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: provider.curTheme,
      theme: ApplicationThemeManager.light(provider.isEn()),
      darkTheme: ApplicationThemeManager.dark(provider.isEn()),
      initialRoute: PageRouteNames.login,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );
  }
}
