



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