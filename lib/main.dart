import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindlee_task/constants/colors.dart';
import 'package:mindlee_task/constants/size.dart';
import 'package:mindlee_task/pages/daily_message_page.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Quicksand',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            foregroundColor: WidgetStateProperty.all(textColor),
            textStyle: WidgetStateProperty.all(
              TextStyle(
                fontSize: deviceFontSize(context, 16),
                fontWeight: FontWeight.w600,
              ),
            ),
            shape: WidgetStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
            minimumSize: WidgetStateProperty.all(
              Size(deviceWidthSize(context, 48), deviceHeightSize(context, 48)),
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            iconColor: WidgetStateProperty.all(iconColor),
            iconSize: WidgetStateProperty.all(deviceFontSize(context, 24)),
            fixedSize: WidgetStateProperty.all(
              Size(deviceWidthSize(context, 32), deviceHeightSize(context, 32)),
            ),
          ),
        ),
      ),
      home: const DailyMessagePage(),
    );
  }
}
