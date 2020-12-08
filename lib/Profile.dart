import 'dart:io';
import 'package:StockMarketApp/firebase_auth.dart';
import 'package:StockMarketApp/landingPage.dart';
import 'package:StockMarketApp/profileUpdate.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_auth.dart';
import 'profileUpdate.dart';

void main() => runApp(ProfileApp());

/// This Widget is the main application widget.
class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  File _profilePic;

  Future<void> getProfilPic() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _profilePic = image;
    });
  }

  // File _coverPic;

  // Future getCoverPic() async {
  //   final image2 = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _coverPic = image2;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Image(
            image: NetworkImage('https://wallpaperaccess.com/full/1188566.jpg'),
            fit: BoxFit.cover,
            height: 200,
            width: double.maxFinite,
          ),

          InkWell(
            onTap: getProfilPic,
            child: Positioned(
                bottom: -50,
                height: -50,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.blueGrey,
                  child: _profilePic == null
                      ? Text("Tap To Add Profile Picture")
                      : CircleAvatar(
                          radius: 100,
                          backgroundImage: FileImage(_profilePic),
                        ),
                )),
          )
        ],
      ),
      SizedBox(
        height: 20,
      ),
      ListTile(
          title: Text(
            'Position',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Trader',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          )),
      ListTile(
          title: Text(
            'Name',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            name == null ? 'NO NAME' : name,
            // name,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          )),
      ListTile(
          title: Text(
            'Bio',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text(
          //   'Beginner trader hoping to improve on my skills. If you have any advice let me know.',
          //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          // )
          subtitle: Text(
            bioChange.text == ""
                ? "Please add a bio when you can"
                : bioChange.text,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          )),
      RaisedButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true)
              .push(MaterialPageRoute(builder: (context) => ProfileUpdate()));
        },
        color: Colors.blue[900],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Update Profile',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChangePasswordWidget()),
          );
          Navigator.pushNamed(context, '/passChange');
        },
        color: Colors.blue[900],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Change Password',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      RaisedButton(
        onPressed: () {
          if (signInMethod == "google") {
            signOutGoogle();
          } else {
            signOutEmail();
          }
          Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(builder: (context) => LandingPage()));
        },
        color: Colors.blue[900],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Sign Out',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
    ]);
  }
}

class ChangePasswordWidget extends StatefulWidget {
  ChangePasswordWidget({Key key}) : super(key: key);

  @override
  ChangePassword createState() => ChangePassword();
}

class ChangePassword extends State<ChangePasswordWidget> {
  final pwChangeFormKey = GlobalKey<FormState>();
  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black);

  final currPWCtrl = TextEditingController();
  final newPWCtrl = TextEditingController();
  final newPWConfirmCtrl = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    currPWCtrl.dispose();
    newPWCtrl.dispose();
    newPWConfirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Form(
          key: pwChangeFormKey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: TextFormField(
                controller: currPWCtrl,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
                obscureText: true,
                style: style,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Current password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
              child: TextFormField(
                controller: newPWCtrl,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
                obscureText: true,
                style: style,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "New password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 2.0),
              child: TextFormField(
                controller: newPWConfirmCtrl,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please enter your new password again';
                  }
                  if (value.trim() != newPWCtrl.text.trim()) {
                    return 'Does not match the new password';
                  }
                  return null;
                },
                obscureText: true,
                style: style,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Confirm new password",
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
                    if (pwChangeFormKey.currentState.validate()) {
                      // Request password change. Reauthentication is done in requestChangePassword().
                      requestChangePassword(
                              currPWCtrl.text.trim(), newPWCtrl.text.trim())
                          .then((value) {
                        print(value);
                        if (value == 0) {
                          Navigator.pop(context);
                        }
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
}
