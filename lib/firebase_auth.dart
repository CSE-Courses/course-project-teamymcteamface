import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';

import 'buySell.dart';
import 'buySell.dart';
import 'buySell.dart';
import 'buySell.dart';
import 'buySell.dart';
import 'buySell.dart';
import 'buySell.dart';

// these variables will store FirebaseUser info
String name;
String email;
String imageUrl;
String currUID;
String signInMethod;
String password;
String bio;
String status = "0";

final firebaseDB = FirebaseDatabase.instance;
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

  // Checking if email and name is null
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  // set local vars to user info
  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  currUID = currentUser.uid;

  // create firebase db reference to access entries
  final ref = firebaseDB.reference().child("users");

  // check if user exists; if not create new entry in db
  ref.orderByChild("uid").equalTo(currentUser.uid);
  DataSnapshot snapshot =
      await ref.orderByChild("uid").equalTo(currentUser.uid).once();
  if (snapshot.value == null) {
    print("adding new user");
    ref.child(currUID).set({
      // add to database
      "name": name,
      "uid": currUID,
      "email": email,
      "photo": imageUrl,
      "bio": bioChange.text,
      "balance": pickBalance.text,
      "status": status
    });
  }

  signInMethod = "google";
  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await _auth.signOut();
  await googleSignIn.signOut();
  await googleSignIn.disconnect();

  print("User Sign Out");
}

// final ref = firebaseDB.reference().child("users");

Future<void> signUpWithEmail(String formName, String formEmail,
    String formPassword, BuildContext context) async {
  final AuthResult authResult = await _auth.createUserWithEmailAndPassword(
      email: formEmail, password: formPassword);
  final FirebaseUser user = authResult.user;

  name = formName;
  //name = currentUser.displayName;
  //UserUpdateInfo userUpdateInfo = UserUpdateInfo();
  //userUpdateInfo.displayName = formName;
  email = user.email;
  currUID = user.uid;
  imageUrl = "";

  assert(await user.getIdToken() != null);

  // create firebase db reference to access entries
  final ref = firebaseDB.reference().child("users");
  // check if user exists; if not create new entry in db
  ref.orderByChild("uid").equalTo(user.uid);
  DataSnapshot snapshot =
      await ref.orderByChild("uid").equalTo(user.uid).once();
  if (snapshot.value == null) {
    print("adding new user");
    ref.set({
      // add to database
      "name": name,
      "uid": currUID,
      "email": email,
      "photo": imageUrl,
      "bio": bioChange.text,
      "balance": pickBalance.text,
      "status": "0"
    });
  }
}

Future<void> signInWithEmail(String formEmail, String formPassword) async {
  final AuthResult authResult = await _auth.signInWithEmailAndPassword(
      email: formEmail, password: formPassword);
  final FirebaseUser user = authResult.user;

  assert(await user.getIdToken() != null);

  email = user.email;
  currUID = user.uid;

  return;
}

void signOutEmail() async {
  await _auth.signOut();
  print('Email User Sign Out');
}

void userSignOut() async {
  name = null;
  currUID = null;
  email = null;
  imageUrl = null;

  if (signInMethod == "google") {
    signOutGoogle();
    return;
  }
  signOutEmail();
  return;
}

String getEmail() {
  return email;
}

FirebaseAuth getAuth() {
  return _auth;
}

Future<int> requestChangePassword(String currPW, String newPW) async {
  final user = await _auth.currentUser();
  AuthCredential cred =
      EmailAuthProvider.getCredential(email: email, password: currPW);
  user.reauthenticateWithCredential(cred).then((value) {
    user.updatePassword(newPW).whenComplete(() {
      return 0;
    }).catchError((error) {
      print(error);
      return 2;
    });
  }).catchError((error) {
    print(error);
    return 1;
  });

  return -1;
}

String formName;
String formBio;

// TextEditingController nameChange = TextEditingController();
TextEditingController bioChange = TextEditingController();
TextEditingController pickBalance = TextEditingController();

Future<String> update() async {
  final ref = firebaseDB.reference().child("users");
  final FirebaseUser currentUser = await _auth.currentUser();

  ref.orderByChild("uid").equalTo(currentUser.uid);
  DataSnapshot snapshot =
      await ref.orderByChild("uid").equalTo(currentUser.uid).once();

  if (snapshot.value != null) {
    ref.child(currentUser.uid).child("bio").set(bioChange.text);
  }

  return 'update succeeded';
}

Future<String> updateProfile() async {
  final ref = firebaseDB.reference().child("users");
  final FirebaseUser currentUser = await _auth.currentUser();
  ref.orderByChild("uid").equalTo(currentUser.uid);
  DataSnapshot snapshot =
      await ref.orderByChild("uid").equalTo(currentUser.uid).once();

  if (snapshot.value != null) {
    ref.child(currentUser.uid).child("photo").set({imageUrl});
  }
  return 'update succeeded';
}

Future<String> balanceSetup() async {
  final ref = firebaseDB.reference().child("users");

  final FirebaseUser currentUser = await _auth.currentUser();
  ref.orderByChild("uid").equalTo(currUID);
  DataSnapshot snapshot =
      await ref.orderByChild("uid").equalTo(currentUser.uid).once();

  if (snapshot.value != null) {
    ref.child(currentUser.uid).child("balance").set(pickBalance.text);
    ref.child(currUID).child("status").set("1");
    status = "1";
  }
  return 'update succeeded';
}

double totalPrice;
double stockPrice = 0.0;

Future<void> buyStock() async {
  final FirebaseUser currentUser = await _auth.currentUser();

  final ref = firebaseDB.reference().child("users");

  ref.orderByChild("uid").equalTo(currUID);
  DataSnapshot snapshot =
      await ref.orderByChild("uid").equalTo(currentUser.uid).once();

  if (snapshot.value != null) {
    // ref
    //     .child(currentUser.uid)
    //     .child("Stocks")
    //     .child("Stock Name")
    //     .set(stockName);

    final track = ref.child(currentUser.uid).child("Stocks");

    ref.child(currentUser.uid).child("Stocks").child("Price").set(prices);

    ref
        .child(currentUser.uid)
        .child("Stocks")
        .child("Quantity")
        .set(totalQuantity);
    ref
        .child(currentUser.uid)
        .child("Stocks")
        .child("totalPrice")
        .set(totalAmount(double.parse(totalQuantity.toString()), prices));

    // buyStock();

    if (track != null) {
      ref.child(currentUser.uid).child("Stocks").child("Price").set(prices);

      ref
          .child(currentUser.uid)
          .child("Stocks")
          .child("Quantity")
          .set(totalQuantity);
      ref
          .child(currentUser.uid)
          .child("Stocks")
          .child("totalPrice")
          .set(totalAmount(double.parse(totalQuantity.toString()), prices));
    }
  }
}
