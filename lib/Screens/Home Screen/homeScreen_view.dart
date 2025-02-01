import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:todoist/Custom%20Widgets/widgets.dart';
import 'package:todoist/Screens/Home%20Screen/homeScreen_viewModlel.dart';
import 'package:todoist/Screens/Login%20Screen/loginScreen_view.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
     onViewModelReady: (viewModel) {
        viewModel.loadUserData(); // Load user data
      },
      viewModelBuilder: () => HomeScreenViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              viewModel.isAdd = true;
              viewModel.customAlertDialog(context);
            },
            shape: const CircleBorder(),
            backgroundColor:themeColor.iconColor,
            child:  Icon(Icons.add, color: themeColor.iconButtonColor,),
          ),
            appBar: AppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(onPressed: (){
                  Scaffold.of(context).openDrawer();
                }, icon:  Icon(Icons.menu, size: 25, color: themeColor.iconColor ));
              }
            ),
            title:const Center(
              child: Text("Progresso", style: TextStyle(fontFamily: "Pacifico", fontSize: 30, color: Color(0xFFE91E63) ),)
                ),
                actions: [
                  IconButton(onPressed: (){
                    viewModel.themeChanger();
                  }, icon: darkTheme ? FaIcon(FontAwesomeIcons.moon, color: themeColor.iconColor, size: 25,)
                  : FaIcon(FontAwesomeIcons.sun, color: themeColor.iconColor, size: 25,)
                  ),
                  IconButton(
                        icon: Icon(
                          Icons.logout,
                          size: 25,
                          color: themeColor.iconColor, 
                        ),
                        onPressed: () {
                          viewModel.fireBase_logOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreenView()), (route) => false);
                        }
                  )
                ], 
            backgroundColor: themeColor.gradient1
            ),
            
          body: viewModel.selectedIndex == 0 
          ? Todo(viewModel: viewModel) : Notepad(viewModel: viewModel),
          
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
            splashColor: Colors.transparent, // Removes the splash effect
            highlightColor: Colors.transparent, // Removes the ripple highlight
            ),
            child: BottomNavigationBar(
                    items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline),
              label: 'To-do',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: 'Notes',
            ),
            
                    ],
                    backgroundColor: themeColor.gradient1,
                    currentIndex: viewModel.selectedIndex,
                    selectedItemColor: themeColor.text2,
                    unselectedItemColor: themeColor.text3,
                    onTap: viewModel.onItemTapped,
                  ),
          ),
    );

      },
    );
  }
}
