import 'dart:io';

import 'package:StockMarketApp/NavPage.dart';
import 'package:StockMarketApp/landingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_auth.dart';

File _profilePic;
TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
String formName;
String formBio;

// TextEditingController nameChange = TextEditingController();
// TextEditingController bioChange = TextEditingController();

void main() => runApp(ProfileUpdate());

class ProfileUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          color: Colors.green,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Update Profile',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 80,
                ),
                FlatButton.icon(
                  // Temporarily commented out because of overflow
                  onPressed: () {
                    updateProfile();
                  },
                  icon: Icon(
                    Icons.photo,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Change Profile Image',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                TextFormField(
                    controller: nameChange,
                    style: style,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Change Name",
                        hintStyle: TextStyle(color: Colors.white)
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(32.0))
                        ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter name change";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      formName = value.trim();
                    }),
                SizedBox(
                  height: 80,
                ),
                TextFormField(
                    controller: bioChange,
                    style: style,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Bio Change",
                        hintStyle: TextStyle(color: Colors.white)

                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(32.0))
                        ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter bio change";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      formBio = value.trim();
                    }),
                RaisedButton(
                    textColor: Colors.white,
                    color: Colors.redAccent,
                    child: Text('SAVE'),
                    onPressed: () {
                      update();
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => NavPage()));
                    })
              ],
            ),
          )),
    );
  }
}
