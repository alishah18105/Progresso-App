import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todoist/Screens/Login%20Screen/loginScreen_viewModel.dart';
import 'package:todoist/Screens/Sign%20Up%20Screen/signUpScreen_view.dart';

class LoginScreenView extends StatelessWidget {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LoginScreenViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1C1F26), // Dark gray
                  Color(0xFF1A202E), // Dark blue-gray
                  Color(0xFF232A3A), // Slightly purple-toned dark
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        "Back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        "We're glad to see you again!",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 50),
                      TextField(
                        controller: viewModel.mail,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                          ),
                          hintText: "Email",
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: viewModel.pass,
                        obscureText: viewModel.obscureText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: const Icon(
                            Icons.key,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              viewModel.hidePassword();
                            },
                            icon: Icon(
                              viewModel.obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color(0xFFFFA500),
                            ),
                          ),
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: viewModel.isChecked,
                            onChanged: (bool? value) {
                              viewModel.checkBoxValue(value);
                            },
                          ),
                          const Text(
                            "Remember Me",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 35),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            viewModel.loginUser(context);
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 11),
                            backgroundColor: Color(0xFFFFA500),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Or Sign Up With",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.apple,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.email,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.facebook,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreenView()));
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color:  Color(0xFFFFA500) ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
