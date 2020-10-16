import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(ProfileApp());

/// This Widget is the main application widget.
class ProfileApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
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

  Future getProfilPic() async {
    final image = await ImagePicker.pickImage(
        source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front);

    setState(() {
      _profilePic = image;
    });
  }

  File _coverPic;

  Future getCoverPic() async {
    final image2 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _coverPic = image2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        // AppBar(
        //     title: const Text('Instructor Profile Page'),
        //     ),
        children: <Widget>[
          Stack(
            // overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              // background image and bottom contents
              Image(
                image: NetworkImage(
                    'https://wallpaperaccess.com/full/1188566.jpg'),
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
                        ? Text('Tap To Add Profile Picture')
                        : CircleAvatar(
                            radius: 100,
                            backgroundImage: FileImage(_profilePic),
                          ),
                    // fit: BoxFit.fill,
                  ),
                  // width: double.infinity,
                  // height: double.infinity,
                  // color: Colors.yellow,

                  // child: Image.network(
                  //   "https://images.unsplash.com/photo-1547721064-da6cfb341d50",
                  // fit: BoxFit.cover,
                  // ),
                ),
              ),
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
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.mail,
              color: Colors.white,
            ),
            label: Text(
              'Email Me',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          ListTile(
              title: Text(
                'Name',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'John Doe',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              )),
          ListTile(
              title: Text(
                'Bio',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Beginner trader hoping to improve on my skills. If you have any advice let me know.',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              )),
          FlatButton(
            child: Text(
              'Change password',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordWidget()),
              );
            },
            color: Colors.blue,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Form(
            key: pwChangeFormKey,
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        return null;
                      },
                      obscureText: true,
                      style: style,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Current password",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        return null;
                      },
                      obscureText: true,
                      style: style,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "New password",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 2.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your new password again';
                        }
                        return null;
                      },
                      obscureText: true,
                      style: style,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Confirm new password",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
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
                            // Process data.
                          }
                        },
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Text("Submit",
                            textAlign: TextAlign.center,
                            style: style.copyWith(color: Colors.white, fontSize: 12.0)),
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
                            style: style.copyWith(color: Colors.white, fontSize: 12.0)),
                      ),
                    ),
                  ),
                ]
            ),
          )
        )
    );
  }
}