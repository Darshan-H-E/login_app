import 'package:flutter/material.dart';
import 'package:login_app/pages/login.page.dart';

class UserOld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30),
      child: Container(
        alignment: Alignment.topRight,
        //color: Colors.red,
        // height: 20,
        child: Row(
          children: <Widget>[
            Text(
              'Have we met before?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                'Sign in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green[500],
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
