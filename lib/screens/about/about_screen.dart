// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';

import '../../components/drawer.dart';
import '../../constants.dart';
import '../../size_config.dart';

class AboutScreen extends StatelessWidget {

  static String routeName = '/about';
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DrawerWidget(
            refresh: null,
            selectedScreen: DrawerOptions.about,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Created by',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kSecondaryColor),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(3),
                      ),
                      Text(
                        'first lieutenant\\ hassan metwally',
                        style: TextStyle(),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kSecondaryColor),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(3),
                      ),
                      Text(
                        'has.metwally@gmail.com',
                        style: TextStyle(),
                      )
                    ],

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'phone',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kSecondaryColor),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(3),
                      ),
                      Text(
                        '+201272899919',
                        style: TextStyle(),
                      )
                    ],

                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
