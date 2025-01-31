import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:todoist/Screens/Home%20Screen/homeScreen_viewModlel.dart';
import 'package:todoist/Screens/Splash%20Screen/splashScreen_viewModel.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SplashScreenViewModel(),
      onViewModelReady: (viewModel) => viewModel.StartUp(context),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Container(
            decoration:  BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  themeColor.gradient1, // Dark gray
                  themeColor.gradient2, // Dark blue-gray
                  themeColor.gradient3, // Slightly purple-toned dark
             
                ],
                center: Alignment(0.8, -0.6),
                radius: 1.2,
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.3, 
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Lottie.asset("assets/images/SplashScreen.json"),
                      width: 250,
                      height: 300,
                    ),
                  ),

                  
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.63, 
                    child:  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       
                        Text(
                          "Progresso",
                          style: TextStyle(
                            fontFamily: "Pacifico",
                            fontSize: 40,
                            color: Color(0xFFE91E63) ,
                            //letterSpacing: 2.0,

                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
