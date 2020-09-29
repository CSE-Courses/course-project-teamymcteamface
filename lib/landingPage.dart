import 'package:flutter/material.dart';
import 'loginPage.dart';
import "login_page.dart";

void main() => runApp(LandingPage());

class LandingPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        body: Container(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(
                  'The \n Stock \n Market\n Game',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Shrikhand',
                  ),
                ),
                ButtonTheme(
                  minWidth: 250.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ),
                      );
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('LOGIN', style: TextStyle(fontSize: 18)),
                  ),
                ),
                ButtonTheme(
                    minWidth: 250.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return MyHomePage();
                            },
                          ),
                        );
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('CREATE NEW ACCOUNT',
                          style: TextStyle(fontSize: 18)),
                    )),
              ])),
        ),
      ),
    );
  }
}
