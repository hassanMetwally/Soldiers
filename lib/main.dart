// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:soldiers/providers/sections_provider.dart';
import 'package:soldiers/providers/suggested_soldiers_provider.dart';
import 'package:soldiers/providers/unit_soldiers_provider.dart';
import 'package:soldiers/screens/splash/splash_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'providers/soldiers_provider.dart';
import 'routes.dart';
import 'theme.dart';

Future<void> main() async {

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(SoldierVacations());

}

class SoldierVacations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SectionsProvider(),),
        ChangeNotifierProvider.value(value: SoldiersProvider(),),
        ChangeNotifierProvider.value(value: SuggestedSoldiersProvider(),),
        ChangeNotifierProvider.value(value: UnitSoldiersProvider(),),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ar'),
        ],
        locale: const Locale('ar'),
        title: 'Soldiers vacations',
        theme: themeData(),
        initialRoute: SplashScreen.routeName,
        routes: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
