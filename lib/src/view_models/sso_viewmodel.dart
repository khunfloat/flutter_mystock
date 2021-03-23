import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SSOModel {
  IconData icon;
  VoidCallback onPressed;
  Color backgroundcolor;
  Color iconcolor;

  SSOModel({
    this.icon,
    this.onPressed,
    this.backgroundcolor,
    this.iconcolor,
  });
}

class SSOViewModel {
  List<SSOModel> get item => [
        SSOModel(
          icon: FontAwesomeIcons.apple,
          backgroundcolor: Color(0xFF323232),
          onPressed: () {
            //todo
          },
        ),
        SSOModel(
          icon: FontAwesomeIcons.google,
          backgroundcolor: Color(0xFFd7483b),
          onPressed: () {
            //todo
          },
        ),
        SSOModel(
          icon: FontAwesomeIcons.facebookF,
          backgroundcolor: Color(0xFF4063ae),
          onPressed: () {
            //todo
          },
        ),
        SSOModel(
          icon: FontAwesomeIcons.line,
          backgroundcolor: Color(0xFF21b54d),
          onPressed: () {
            //todo
          },
        ),
      ];
}
