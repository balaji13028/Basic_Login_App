import 'dart:async';
import 'dart:developer';

import 'package:devpoint_solutions/models/userprofile_data.dart';
import 'package:devpoint_solutions/pages/home_page.dart';
import 'package:devpoint_solutions/pages/login_page.dart';
import 'package:devpoint_solutions/services/firestore_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStoreProvider extends ChangeNotifier {
  var isloading = false;
  User? loginDetails;
  UserProfileData user = UserProfileData();

  bool checkUserLoginStatus() {
    final user = FirebaseAuth.instance.currentUser;
    loginDetails = user;
    return user != null;
  }

  Future signIn(email, password, context) async {
    showDialog(
        context: context,
        builder: ((context) => const Center(
              child: CircularProgressIndicator(),
            )));
    try {
      var values = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      loginDetails = values.user;
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  const HomePage())));
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      log(e.toString());
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'No user found for the email',
              textAlign: TextAlign.center,
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Wrong password',
              textAlign: TextAlign.center,
            )));
      } else {
        //if (e.code == 'too-many-requests') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Have a server issue, Please try again after sometime',
              textAlign: TextAlign.center,
            )));
      }
    }
  }

  Future createAccount(
      {required email,
      required password,
      required gender,
      required name,
      required context}) async {
    showDialog(
        context: context,
        builder: ((context) => const Center(
              child: CircularProgressIndicator(),
            )));
    try {
      await FirestoreApi().createUser(
        email: email,
        password: password,
        name: name,
        gender: gender,
        context: context,
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Account created successfully',
          textAlign: TextAlign.center,
        ),
      ));
    } catch (e) {
      print((e));
    }
  }

  Future logout(context) async {
    showDialog(
        context: context,
        builder: ((context) => const Center(
              child: CircularProgressIndicator(),
            )));
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginPage()));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
