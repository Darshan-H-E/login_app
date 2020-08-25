import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_app/widget/first.dart';
import 'package:login_app/widget/textLogin.dart';
import 'package:login_app/widget/verticalText.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // GoogleSignIn _googleSignIn= GoogleSignIn(scopes: []);

  String email;
  String password;
  Future loginin(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 2;
    } catch (error) {
      return 1;
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _showsnackbar() {
    final snackBar = new SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text('wrong email or password'),
      duration: Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  String error = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    VerticalText('Sign In'),
                    TextLogin(),
                  ]),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: _emailController,
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.lightBlueAccent,
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: _passwordController,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                     signInWithGoogle();
                    },
                    child: Text('data'),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, right: 50, left: 200),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green[500],
                            blurRadius:
                                10.0, // has the effect of softening the shadow
                            spreadRadius:
                                1.0, // has the effect of extending the shadow
                            offset: Offset(
                              1.0, // horizontal, move right 10
                              1.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            // setState(() => loading = true);
                            dynamic result = await loginin(email, password);
                            if (result == 1) {
                              _showsnackbar();
                            }
                            if (result == null) {
                              setState(() {
                                // loading = false;
                                error = 'Please supply a valid email';
                              });
                            }
                            if (result == 2) {
                              _emailController.clear();
                              _passwordController.clear();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => HomePage()),
                              // );
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.green[500],
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.green[500],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FirstTime(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async{
  await googleSignIn.signOut();

  print("User Sign Out");
}
