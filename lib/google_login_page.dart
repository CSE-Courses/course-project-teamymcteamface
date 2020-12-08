import 'package:StockMarketApp/balance.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'NavPage.dart';
import 'firebase_auth.dart';

void main() => runApp(GLoginPage());

class GLoginPage extends StatelessWidget {
  //@override
  //_LoginPageState createState() => _LoginPageState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: _LoginPageState(),
        initialRoute: '/login',
        routes: {
          '/login': (context) => _LoginPageState(),
          '/passReset': (context) => ResetPasswordWidget(),
        });
  }
}

class _LoginPageState extends StatefulWidget {
  _LoginPageState({Key key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<_LoginPageState> {
  final _loginKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  //String formEmail;
  //String formPassword;

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.green,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/logo.png"), height: 190.0),
              SizedBox(height: 50),
              _emailLoginForm(),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailLoginForm() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Form(
          key: _loginKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: emailCtrl,
                style: style,
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                /*onSaved: (String value) {
                  formEmail = value.trim();
                  print(formEmail);
                },*/
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
              ),
              TextFormField(
                controller: passCtrl,
                obscureText: true,
                style: style,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                /*onSaved: (String value) {
                  formPassword = value.trim();
                },*/
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xff01A0C7),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        if (_loginKey.currentState.validate()) {
                          //_loginKey.currentState.save();
                          String email = emailCtrl.text.trim();
                          String pass = passCtrl.text.trim();
                          signInWithEmail(email, pass).then((value) {
                            print(currUID);
                            if (currUID != null) {
                              // Temporary hacky way to check if auth is valid
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  settings: RouteSettings(name: "/NavPage"),
                                  builder: (context) {
                                    return NavPage();
                                  },
                                ),
                              );
                            }
                          }).catchError((error) {
                            print(error);
                          });
                        }
                      },
                      child: Text("Login",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(32.0),
                  color: Color(0xff01A0C7),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    onPressed: () {
                      Navigator.pushNamed(context, '/passReset');
                    },
                    child: Text("Reset password",
                        textAlign: TextAlign.center,
                        style: style.copyWith(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          // ignore: unrelated_type_equality_checks
          pickBalance.text == ""
              ? Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Balance();
                    },
                  ),
                )
              : Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return NavPage();
                    },
                  ),
                );
          count++;
          print(count);
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/gg.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResetPasswordWidget extends StatefulWidget {
  ResetPasswordWidget({Key key}) : super(key: key);

  @override
  ResetPassword createState() => ResetPassword();
}

class ResetPassword extends State<ResetPasswordWidget> {
  final pwResetFormKey = GlobalKey<FormState>();
  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black);

  final emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Form(
          key: pwResetFormKey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: TextFormField(
                controller: emailCtrl,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                style: style,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(32.0),
                color: Color(0xff01A0C7),
                child: MaterialButton(
                  onPressed: () {
                    if (pwResetFormKey.currentState.validate()) {
                      // Request password change. Reauthentication is done in requestChangePassword().
                      FirebaseAuth _auth = getAuth();
                      _auth
                          .sendPasswordResetEmail(email: emailCtrl.text.trim())
                          .then((value) {
                        //Navigator.pop(context);
                      }).catchError((error) {
                        print(error);
                      });
                    }
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Text("Submit",
                      textAlign: TextAlign.center,
                      style:
                          style.copyWith(color: Colors.white, fontSize: 12.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(32.0),
                color: Color(0xff01A0C7),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel",
                      textAlign: TextAlign.center,
                      style:
                          style.copyWith(color: Colors.white, fontSize: 12.0)),
                ),
              ),
            ),
          ]),
        )));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailCtrl.dispose();
    super.dispose();
  }
}
