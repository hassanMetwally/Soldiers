// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),
        () => Navigator.of(context).pushNamed(HomeScreen.routeName));

    return Scaffold(
      body: Container(
        child: Center(
            child: Image.asset(
          'assets/images/egypt.jpg',
          width: 500,
          height: 500,
        )),
      ),
    );
  }
}
