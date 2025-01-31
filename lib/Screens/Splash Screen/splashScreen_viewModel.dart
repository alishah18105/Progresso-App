import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todoist/Screens/Home%20Screen/homeScreen_view.dart';
import 'package:todoist/Screens/Login%20Screen/loginScreen_view.dart';



class SplashScreenViewModel extends BaseViewModel {

  final User? user = FirebaseAuth.instance.currentUser;

  void StartUp(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreenView()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreenView()),
        );
      }
    });
  }


}
