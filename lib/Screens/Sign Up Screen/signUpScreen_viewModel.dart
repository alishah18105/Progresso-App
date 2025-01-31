import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String? currentUserId;

class SignUpScreenViewModel extends BaseViewModel {
  bool isChecked = false;
  bool obscureText = true;
  bool obscureText2 = true;
  

  TextEditingController mail = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();

  String text = "";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> signupUser(BuildContext context) async {
    try {
      // Create user with FirebaseAuth
      final UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail.text,
        password: pass.text,
      );

      // Store the user ID globally
      User? user = credential.user;
      if (user != null) {
        currentUserId = user.uid;
        print("User ID: $currentUserId");

        // Add the user data to Firestore
        await firestore.collection('users').doc(currentUserId).set({
          'name': name.text.trim(),
          'email': mail.text.trim(),
          'tasks': [],
        });
        print("User Sign-Up & Data Stored Successfully");
      }
      text = "";
      notifyListeners();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            'Sign Up Successfully',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth errors
      if (e.code == 'weak-password') {
        text = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        text = 'The account already exists for that email.';
      } else {
        text = e.message ?? "An unknown error occurred.";
      }
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Catch any other errors
      print("Error: $e");
      text = "An error occurred: $e";
      notifyListeners();
    }
  }

  // Checkbox handler
  void checkBoxValue(bool? value) {
    isChecked = value ?? false;
    notifyListeners();
  }

  // Password visibility toggles
  void hidePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void hidePassword2() {
    obscureText2 = !obscureText2;
    notifyListeners();
  }
}
