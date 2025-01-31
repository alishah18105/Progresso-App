import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:todoist/Screens/Home%20Screen/homeScreen_viewModlel.dart';
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
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeColor.gradient1, // Dark gray
                  themeColor.gradient2, // Dark blue-gray
                  themeColor.gradient3, // Slightly purple-toned dark
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
                         Text(
                          "Welcome",
                          style: TextStyle(
                            color: themeColor.text1,
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                         Text(
                          "Back",
                          style: TextStyle(
                            color: themeColor.text1,
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                         Text(
                          "We're glad to see you again!",
                          style: TextStyle(
                            color: themeColor.text2,
                            
                          ),
                        ),
                    
                        const SizedBox(height: 50),
                    
                        TextField(
                          style: TextStyle(color: themeColor.startText3 ),
                          controller: viewModel.mail,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: themeColor.tileColor1 ,
                            enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: themeColor.tileColor1), // Default border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: themeColor.tileColor2)
                            ),
                            prefixIcon:  Icon(
                              Icons.email_outlined,
                              color: themeColor.text1,
                            ),
                            labelStyle: TextStyle(color: themeColor.text1),
                            hintText: "Email",
                            hintStyle:  TextStyle(color: themeColor.text1),
                          ),
                        ),
                    
                        const SizedBox(height: 10),
                        TextField(
                          style: TextStyle(color: themeColor.startText3),
                          controller: viewModel.pass,
                          obscureText: viewModel.obscureText,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: themeColor.tileColor2,
                           enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: themeColor.tileColor2), // Default border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: themeColor.tileColor1)
                            ),
                            prefixIcon:  Icon(
                              Icons.key,
                              color: themeColor.text1,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                viewModel.hidePassword();
                              },
                              icon: Icon(
                                viewModel.obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: themeColor.text1,
                              ),
                            ),
                            
                            hintText: "Password",
                            hintStyle: TextStyle(color: themeColor.text1),
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
                                 Text(
                              "Remember Me",
                              style: TextStyle(color: themeColor.text1),
                            ),
                              ],
                            ),
                            
                            TextButton(
                              onPressed: () {},
                              child:  Text(
                                "Forgot Password?",
                                style: TextStyle(color: themeColor.elevatedButtonColor),
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
                              backgroundColor: themeColor.elevatedButtonColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                         Center(
                          child: Text(
                            "Or Sign In With",
                            style: TextStyle(color: themeColor.text1),
                          ),
                        ),
                        const SizedBox(height: 30),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: FaIcon(
                                FontAwesomeIcons.github,
                                size: 30,
                                color:themeColor.text1,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: FaIcon(
                                FontAwesomeIcons.google,
                                size: 30,
                                color: themeColor.text1,
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: FaIcon(
                                FontAwesomeIcons.linkedin,
                                size: 30,
                                color:themeColor.text1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              "Don't have an account?",
                              style: TextStyle(color:themeColor.text1,),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreenView()));
                              },
                              child:  Text(
                                "Sign Up",
                                style: TextStyle(color: themeColor.elevatedButtonColor ),
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
