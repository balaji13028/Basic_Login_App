import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devpoint_solutions/models/userprofile_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreApi {
  final db = FirebaseFirestore.instance.collection('users');

  Future createUser({
    required email,
    required password,
    required name,
    required gender,
    required context,
  }) async {
    final docUser = db.doc(); //to get id to store with a id.
    UserProfileData user = UserProfileData(
      id: docUser.id,
      name: name,
      email: email,
      password: password,
      gender: gender,
    );
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await docUser.set(user.toMap()).then((value) => log('user added'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Email already existed, Signin to continue',
              textAlign: TextAlign.center,
            )));
      }
    }
  }
}
