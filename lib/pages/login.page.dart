import 'package:flutter/material.dart';
import 'package:login_app/widget/button.dart';
import 'package:login_app/widget/first.dart';
import 'package:login_app/widget/forgot.dart';
import 'package:login_app/widget/inputEmail.dart';
import 'package:login_app/widget/password.dart';
import 'package:login_app/widget/textLogin.dart';
import 'package:login_app/widget/verticalText.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey[700], Colors.grey[900]]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                InputEmail(),
                PasswordInput(),
                ButtonLogin(),
                FirstTime(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
