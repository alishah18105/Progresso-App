
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:todoist/Screens/Home%20Screen/homeScreen_viewModlel.dart';
import 'package:todoist/Screens/Login%20Screen/loginScreen_view.dart';
import 'package:todoist/Screens/Sign%20Up%20Screen/signUpScreen_viewModel.dart';

class SignUpScreenView extends StatelessWidget {
  const SignUpScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignUpScreenViewModel(), 
      builder: (context, viewModel, child){
        return Scaffold(
      body: Container(
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
        child: LayoutBuilder(
          builder: (context, constraints){
          return SingleChildScrollView(
            child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight, // Fill the screen height
                  ),
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.only(top:16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("Join Us Today!",style: TextStyle(color: themeColor.text1 , fontSize: 35, fontWeight: FontWeight.w800),),
                        Text("Sign up and explore endless possibilities", style: TextStyle(color: themeColor.text2),),
                      const SizedBox(height: 40),
                  
                      TextField(
                        style: TextStyle(color: themeColor.startText3),
                        controller: viewModel.mail,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: themeColor.tileColor1,
                          enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: themeColor.tileColor1), // Default border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: themeColor.tileColor2)
                            ),
                        prefixIcon:  Icon(Icons.email_outlined,color: themeColor.text1),
                        hintText: "Email",
                        hintStyle: TextStyle(color: themeColor.text1)
                        ),
                  
                      ),
                     const  SizedBox(height: 10,),
                          
                      TextField(
                        style: TextStyle(color: themeColor.startText3),
                          controller: viewModel.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:themeColor.tileColor2,
                          enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: themeColor.tileColor2), // Default border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: themeColor.tileColor1)
                            ),
                        prefixIcon:  Icon(Icons.person_2_outlined,color: themeColor.text1),
                        hintText: "Full Name",
                        hintStyle: TextStyle(color: themeColor.text1)
                          
                        ),
                  
                      ), const  SizedBox(height: 10,),
                                
                      TextField(
                        style: TextStyle(color: themeColor.startText3),
                          controller: viewModel.pass,
                        obscureText: viewModel.obscureText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:  themeColor.tileColor1,
                           enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: themeColor.tileColor1), // Default border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: themeColor.tileColor2)
                            ),
                        prefixIcon: Icon(Icons.key,color:themeColor.text1),
                        suffixIcon: IconButton(onPressed: (){
                          viewModel.hidePassword();
                        }, icon: Icon(viewModel.obscureText ? Icons.visibility_off : Icons.visibility,color:themeColor.text1)),
                        hintText: "Password",
                        hintStyle: TextStyle(color: themeColor.text1)
                          
                        ),
                  
                      ),
                           const SizedBox(height: 10,),
                                
                      TextField(
                        style: TextStyle(color: themeColor.startText3),
                        controller: viewModel.cpass,
                        obscureText: viewModel.obscureText2,
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
                        prefixIcon:  Icon(Icons.key,color:themeColor.text1),
                        suffixIcon: IconButton(onPressed: (){
                          viewModel.hidePassword2();
                        }, icon: Icon(viewModel.obscureText2 ? Icons.visibility_off : Icons.visibility,color:  themeColor.text1)),
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(color: themeColor.text1)
                          
                        ),
                  
                      ),
                          
                          
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        
                        children: [
                          Row(
                            children: [
                              Checkbox(value: viewModel.isChecked, onChanged: (bool? value){
                               viewModel.checkBoxValue(value);
                              }),
                              Text("Agree with",style: TextStyle(color: themeColor.text1),),
                            ],
                          ),
                           
                          TextButton(onPressed: (){}, child: Text("Terms & Conditions",style: TextStyle(color: themeColor.text2)),
                          ),
                        ],
                      ),
                     const  SizedBox(height: 10,),
                      Center(
                        child: ElevatedButton(onPressed: (){
                          viewModel.signupUser(context);
                        
                        }, child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold),), style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 80, vertical:11),
                          backgroundColor:  themeColor.elevatedButtonColor,
                        ),),
                      ),
                     const  SizedBox(height: 20,),
                       Center(child: Text("Or Sign Up With", style: TextStyle(color:themeColor.text1),)),
                                 const  SizedBox(height: 20),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: FaIcon(
                                FontAwesomeIcons.github,
                                size: 30,
                                color: themeColor.text1,
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
                                color: themeColor.text1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [ 
                            Text("Already have an account?" ,style: TextStyle(color: themeColor.text1),),
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreenView()));
                        }, child: Text("Sign In", style: TextStyle(color:  themeColor.elevatedButtonColor),) )]
                        )
                          
                    ],
                    
                  ),
                ),
              ),
            ),
          ),
        );
          }
      ),
        ),
        );
      }
      );
  }
}