import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Login';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  LoginRoute createState() => LoginRoute();
}
//class _MyStatefulWidgetState extends State<MyStatefulWidget> {
class LoginRoute extends State<MyStatefulWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:32.0),
                      child: Image(
                        height: 100,
                        image: NetworkImage('https://image.flaticon.com/icons/png/512/15/15464.png'),
                        //fit: BoxFit.,
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Material(
                      color: Colors.white30,
                      child: InkWell(
                        child: Text('Forgot username / password'),
                        onTap:(){},
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is valid.
                          if (_formKey.currentState.validate()) {
                            // Process data.
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SecondRoute()),
                            );*/
                          }
                        },
                        child: Text('Login'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Center(
                      child: Material(
                        color: Colors.white30,
                        child: InkWell(
                          child: Text('Sign up'),
                          onTap:() {
                            /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SecondRoute()),
                            );*/
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
