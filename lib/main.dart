import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/screen/home_screen/home_screen.dart';
import 'package:namaz_app/screen/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import '../../language/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'language/app_language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguageProvider appLanguage = AppLanguageProvider();
  await appLanguage.fetchLocale();
  await AndroidAlarmManager.initialize();
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=> AppLanguageProvider()),
    ],
    child: MyApp(
      appLanguage: appLanguage,
    ),
  ));
}

class MyApp extends StatelessWidget {

  AppLanguageProvider? appLanguage;
  MyApp({super.key, required this.appLanguage});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>appLanguage,
      child: Consumer<AppLanguageProvider>(builder: (context, model, child) {
        return MaterialApp(
          title: 'Namaz App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home:
          const SplashScreen(),
          locale: model.appLocal,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('tr', 'TR'),
            Locale('fr', 'FR'),
            Locale('ar', 'SA'),
            Locale('de', 'DE'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      }),
    );
  }}
