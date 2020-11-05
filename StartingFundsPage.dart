import 'package:flutter/material.dart';
import 'NavPage.dart';
import 'firebase_auth.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _createAccFormKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  Integer startingFunds;

  @override
  Widget build(BuildContext context) {
    final startingFunds = TextFormField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Starting Funds",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your preferred starting amount.";
          }
          return null;
        },
        onSaved: (String value) {
          formName = value.trim();
        }
    );

    final beginStockJourney = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          //if(_createAccFormKey.currentState.validate()) {
            //_createAccFormKey.currentState.save();

            // Move to NavPage when signup is completed.
            //signUpWithEmail(formName, formEmail, formPassword, context).whenComplete(() {
              //if(currUID != null) { // Temporary hacky way to check if auth is valid
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: RouteSettings(name: "/NavPage"),
                    builder: (context) {
                      return NavPage();
                    },
                  ),
                );
              //}
            //});
          //}
        },
        child: Text("Begin Stock Journey",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _createAccFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 45.0),
                  nameField,
                  SizedBox(height: 25.0),
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  createAccButton,
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
