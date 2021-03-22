


import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Header'),
              Text('login'),
              Text('login button'),
              Text('forgot password'),
              Text('sso'),
            ],
          ),
        ],
      ),
    );
  }
}
