// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:soldiers/screens/about/about_screen.dart';
import 'package:soldiers/screens/home/home_screen.dart';
import 'package:soldiers/screens/section_soldiers/section_soldiers_screen.dart';
import 'package:soldiers/screens/sections/sections_screen.dart';
import 'package:soldiers/screens/splash/splash_screen.dart';
import 'package:soldiers/screens/unit_soldiers/unit_soldiers_screen.dart';


Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  SectionsScreen.routeName: (context) => SectionsScreen(),
  SectionSoldiersScreen.routeName: (context) => SectionSoldiersScreen(),
  UnitSoldiersScreen.routeName: (context) => UnitSoldiersScreen(),
  AboutScreen.routeName: (context) => AboutScreen(),
};
