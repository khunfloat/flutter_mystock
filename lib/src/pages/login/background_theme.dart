



import 'package:flutter/material.dart';

class BackGroundTheme {
  const BackGroundTheme();

  static const gradientStart = const Color(0XFFb20a2c);
  static const gradientEnd = const Color(0XFFfffbd5);

  static const gradient = LinearGradient(
    colors: [
      gradientStart,
      gradientEnd,

    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.0, 0.7],
  );
}

class BackGroundThemedark {
  const BackGroundThemedark();

  static const gradientStart = const Color(0XFFED213A);
  static const gradientEnd = const Color(0XFF93291E);

  static const gradient = LinearGradient(
    colors: [
      gradientStart,
      gradientEnd,

    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.0, 1.0],
  );
}