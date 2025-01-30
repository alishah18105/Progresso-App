
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
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
                       Text("Join Us Today!",style: TextStyle(color: Colors.white , fontSize: 35, fontWeight: FontWeight.w800),),
                        Text("Sign up and explore endless possibilities", style: TextStyle(color: Colors.lightBlue),),
                      const SizedBox(height: 40),
                  
                      TextField(
                        style: TextStyle(color: Colors.white),
                        controller: viewModel.mail,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:  Color(0xFF2F353D),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        prefixIcon:  Icon(Icons.email_outlined,color: Colors.white),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white)
                        ),
                  
                      ),
                     const  SizedBox(height: 10,),
                          
                      TextField(
                        style: TextStyle(color: Colors.white),
                          controller: viewModel.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:const  Color(0xFF5E5A78),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        prefixIcon:  Icon(Icons.person_2_outlined,color: Colors. white),
                        hintText: "Full Name",
                        hintStyle: TextStyle(color: Colors.white)
                          
                        ),
                  
                      ), const  SizedBox(height: 10,),
                                
                      TextField(
                        style: TextStyle(color: Colors.white),
                          controller: viewModel.pass,
                        obscureText: viewModel.obscureText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:  Color(0xFF2F353D),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        prefixIcon: Icon(Icons.key,color: Colors.white),
                        suffixIcon: IconButton(onPressed: (){
                          viewModel.hidePassword();
                        }, icon: Icon(viewModel.obscureText ? Icons.visibility_off : Icons.visibility,color: const Color(0xFF40E0D0))),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white)
                          
                        ),
                  
                      ),
                           const SizedBox(height: 10,),
                                
                      TextField(
                        style: TextStyle(color: Colors.white),
                        controller: viewModel.cpass,
                        obscureText: viewModel.obscureText2,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const  Color(0xFF5E5A78),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        prefixIcon:  Icon(Icons.key,color:Colors.white,),
                        suffixIcon: IconButton(onPressed: (){
                          viewModel.hidePassword2();
                        }, icon: Icon(viewModel.obscureText2 ? Icons.visibility_off : Icons.visibility,color:  const Color(0xFF40E0D0))),
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(color: Colors.white)
                          
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
                              Text("Agree with",style: TextStyle(color: Colors.white),),
                            ],
                          ),
                           
                          TextButton(onPressed: (){}, child: Text("Terms & Conditions",style: TextStyle(color: Colors.lightBlue)),
                          ),
                        ],
                      ),
                     const  SizedBox(height: 10,),
                      Center(
                        child: ElevatedButton(onPressed: (){
                          viewModel.signupUser(context);
                        
                        }, child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold),), style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 80, vertical:11),
                          backgroundColor:  const Color(0xFFFFA500),
                        ),),
                      ),
                     const  SizedBox(height: 20,),
                      const  Center(child: Text("Or Sign Up With", style: TextStyle(color: Colors.white),)),
                                 const  SizedBox(height: 20),
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
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [ 
                           const Text("Already have an account?" ,style: TextStyle(color: Colors.white),),
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreenView()));
                        }, child: const  Text("Sign In", style: TextStyle(color:  Color(0xFFFFA500)),) )]
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