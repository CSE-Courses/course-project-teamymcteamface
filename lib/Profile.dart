import 'dart:io';
import 'package:StockMarketApp/landingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_auth.dart';
import 'google_login_page.dart';

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

/*var name = "";
 final FirebaseAuth _auth = FirebaseAuth.instance;
 getCurrentUID() async {
   final FirebaseUser user = await _auth.currentUser();
   name = user.email; // Will store email for now because of firebase problems.
 }*/

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
    //getCurrentUID();
    // String name = getEmail();

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
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                            imageUrl,
                          ))
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
          /*FlatButton.icon( // Temporarily commented out because of overflow
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
          ),*/
          ListTile(
              title: Text(
                'Name', // Will display email for now because of firebase problems.
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                name, // Will display email for now because of firebase problems.
                //"John Doe",
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
        ]);
  }
}
