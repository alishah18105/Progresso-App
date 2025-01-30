import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
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
                            color: Colors.lightBlue,
                            
                          ),
                        ),
                    
                        const SizedBox(height: 50),
                    
                        TextField(
                          style: TextStyle(color: Colors.white),
                          controller: viewModel.mail,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF2F353D) ,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: "Email",
                            hintStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                    
                        const SizedBox(height: 10),
                        TextField(
                          style: TextStyle(color: Colors.white),
                          controller: viewModel.pass,
                          obscureText: viewModel.obscureText,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const  Color(0xFF5E5A78),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: const Icon(
                              Icons.key,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                viewModel.hidePassword();
                              },
                              icon: Icon(
                                viewModel.obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xFF40E0D0),
                              ),
                            ),
                            
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
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
                              ],
                            ),
                            
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
                                  horizontal: 60, vertical: 11),
                              backgroundColor: Color(0xFFFFA500),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            "Or Sign In With",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: FaIcon(
                                FontAwesomeIcons.github,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: FaIcon(
                                FontAwesomeIcons.google,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: FaIcon(
                                FontAwesomeIcons.linkedin,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
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
          ),
        );
      },
    );
  }
}
