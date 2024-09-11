import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData themeData() {
  final materialColor = MaterialColor(kSecondaryColor.value, {
    50: kSecondaryColor.withOpacity(0.1),
    100: kSecondaryColor.withOpacity(0.2),
    200: kSecondaryColor.withOpacity(0.3),
    300: kSecondaryColor.withOpacity(0.4),
    400: kSecondaryColor.withOpacity(0.5),
    500: kSecondaryColor.withOpacity(0.6),
    600: kSecondaryColor.withOpacity(0.7),
    700: kSecondaryColor.withOpacity(0.8),
    800: kSecondaryColor.withOpacity(0.9),
    900: kSecondaryColor.withOpacity(1.0),
  });
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,

    primarySwatch: materialColor,

    fontFamily: 'Muli',
  );
}
