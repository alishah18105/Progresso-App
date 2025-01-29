
import 'package:flutter/material.dart';
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text("Join Us Today!",style: TextStyle(color: Colors.white , fontSize: 40, fontWeight: FontWeight.w800),),
                      Text("Sign up and explore endless possibilities", style: TextStyle(color: Colors.lightBlue ,fontWeight: FontWeight.w600),),
                    const SizedBox(height: 40),
                
                    TextField(
                      controller: viewModel.mail,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      prefixIcon:  Icon(Icons.email_outlined,color: Colors.black),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.black)
                      ),
                
                    ),
                   const  SizedBox(height: 10,),
                        
                    TextField(
                        controller: viewModel.name,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      prefixIcon:  Icon(Icons.person_2_outlined,color: Colors.black),
                      hintText: "Full Name",
                      hintStyle: TextStyle(color: Colors.black)
                        
                      ),
                
                    ), const  SizedBox(height: 10,),
              
                    TextField(
                        controller: viewModel.pass,
                      obscureText: viewModel.obscureText,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      prefixIcon: Icon(Icons.key,color: Colors.black),
                      suffixIcon: IconButton(onPressed: (){
                        viewModel.hidePassword();
                      }, icon: Icon(viewModel.obscureText ? Icons.visibility_off : Icons.visibility,color:  Color(0xFFFFA500))),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.black)
                        
                      ),
                
                    ),
                         const SizedBox(height: 10,),
              
                    TextField(
                      controller: viewModel.cpass,
                      obscureText: viewModel.obscureText2,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      prefixIcon:  Icon(Icons.key,color:Colors.black,),
                      suffixIcon: IconButton(onPressed: (){
                        viewModel.hidePassword2();
                      }, icon: Icon(viewModel.obscureText2 ? Icons.visibility_off : Icons.visibility,color:  Color(0xFFFFA500))),
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(color: Colors.black)
                        
                      ),
                
                    ),
                        
                        
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start
                      ,
                      children: [
                        Checkbox(value: viewModel.isChecked, onChanged: (bool? value){
                         viewModel.checkBoxValue(value);
                        }),
                         Text("Agree with",style: TextStyle(color: Colors.white),),
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
                        backgroundColor:  Color(0xFFFFA500),
                      ),),
                    ),
                   const  SizedBox(height: 20,),
                     Center(child: Text("Or Sign Up With", style: TextStyle(color: Colors.white),)),
               const  SizedBox(height: 20),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.apple, size:40, color: Colors.white,),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.mail, size:30, color: Colors.white), 
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.facebook, size: 35, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ 
                         Text("Already have an account?" ,style: TextStyle(color: Colors.white),),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreenView()));
                      }, child:  Text("Sign In", style: TextStyle(color:  Color(0xFFFFA500)),) )]
                      )
                        
                  ],
                  
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