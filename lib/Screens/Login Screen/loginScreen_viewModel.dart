import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todoist/Screens/Home%20Screen/homeScreen_view.dart';
import 'package:todoist/Screens/Sign%20Up%20Screen/signUpScreen_viewModel.dart';

class LoginScreenViewModel extends BaseViewModel {
  bool isChecked = false;
  bool obscureText = true;
  String text = "";
  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();

  // Firebase login function
  Future<void> loginUser(BuildContext context) async {
    try {
      // Log in the user
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail.text.trim(),
        password: pass.text.trim(),
      );

      // Store the current user ID globally
      User? user = credential.user;
      if (user != null) {
        currentUserId = user.uid; // Update the global variable
        print("Logged-in User ID: $currentUserId");
      }

      // Navigate to the Home Screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreenView()),
      );

      text = "";
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Handle Firebase login errors
      if (e.code == 'user-not-found') {
        text = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        text = "Wrong password provided for that user.";
      } else {
        text = e.message ?? "An unknown error occurred.";
      }
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // Toggle password visibility
  void hidePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  // Handle checkbox value
  void checkBoxValue(bool? value) {
    isChecked = value ?? false;
    notifyListeners();
  }
}
