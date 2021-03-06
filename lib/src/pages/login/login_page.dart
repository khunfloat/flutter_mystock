import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_stock/src/configs/app_route.dart';
import 'package:my_stock/src/constants/app_setting.dart';
import 'package:my_stock/src/constants/asset.dart';
import 'package:my_stock/src/pages/login/background_theme.dart';
import 'package:my_stock/src/view_models/sso_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            // color: Colors.amber,
            decoration: BoxDecoration(
              gradient: BackGroundTheme.gradient,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 120),
                Image.asset(Asset.logoImage),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Card(
                      margin: EdgeInsets.only(
                        top: 50,
                        bottom: 70,
                        left: 22,
                        right: 22,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 22,
                          right: 22,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: _usernameController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "example@domain.com",
                                labelText: "USERNAME",
                                icon: Icon(Icons.person),
                                border: InputBorder.none,
                              ),
                            ),
                            Divider(
                              height: 5,
                              indent: 22,
                              endIndent: 22,
                            ),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: "PASSWORD",
                                icon: Icon(Icons.lock),
                                border: InputBorder.none,
                              ),
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 220,
                      height: 50,
                      decoration: _boxDecoration(),
                      child: TextButton(
                        onPressed: () async {
                          final username = _usernameController.text;
                          final password = _passwordController.text;

                          if (username == "admin" && password == "admin") {
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            // int counter = (prefs.getInt('counter') ?? 0) + 1;
                            // print('Pressed $counter times.');
                            // await prefs.setInt('counter', counter);

                            var token = "fjdsjklafjdskla;fjd";
                            prefs.setString(AppSetting.tokenSetting, token);
                            prefs.setString(AppSetting.usernameSetting, token);


                            Navigator.pushReplacementNamed(
                              context, AppRoute.homeRoute);
                          } else {
                            print("password is incorrect!!");
                          }
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildTextButton(
                  onPressd: () {},
                  text: "forgot password",
                ),
                SSOButton(),
                _buildTextButton(
                  onPressd: () {},
                  text: "register here",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    final gradientStart = Color(0XFFED213A);
    final gradientEnd = Color(0XFF93291E);

    final boxShadowItem = (Color color) =>
        BoxShadow(
          color: color,
          offset: Offset(1.0, 6.0),
          blurRadius: 3.0,
        );

    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      boxShadow: <BoxShadow>[
        boxShadowItem(gradientStart),
        boxShadowItem(gradientEnd),
      ],
      gradient: LinearGradient(
        colors: [
          gradientEnd,
          gradientStart,
        ],
        begin: const FractionalOffset(0, 0),
        end: const FractionalOffset(1.0, 1.0),
        stops: [0.0, 1.0],
      ),
    );
  }

  Container _buildTextButton(
      {VoidCallback onPressd, String text = "eror please insert text"}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: TextButton(
        onPressed: onPressd,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}

class SSOButton extends StatelessWidget {
  const SSOButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: SSOViewModel()
              .item
              .map(
                (item) =>
                FloatingActionButton(
                  heroTag: item.backgroundcolor.toString(),
                  onPressed: item.onPressed,
                  child: FaIcon(
                    item.icon,
                    color: item.iconcolor,
                  ),
                  backgroundColor: item.backgroundcolor,
                ),
          )
              .toList()),
    );
  }
}
