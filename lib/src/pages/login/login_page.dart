import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            // color: Colors.amber,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0XFFf12711),
                  Color(0XFFf5af19),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 1.0],
              ),
            ),
          ),
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
