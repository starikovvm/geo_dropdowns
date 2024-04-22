import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geo_dropdowns/features/home/home_widget.dart';
import 'package:geo_dropdowns/repositories/repositories_injector.dart';
import 'package:geo_dropdowns/ui/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    RepositoriesInjector(
      child: EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: appThemeData,
      home: const HomeWidget(),
    );
  }
}
