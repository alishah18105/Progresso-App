import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
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
            backgroundColor:viewModel.themeColor.iconColor,
            child:  Icon(Icons.add, color: viewModel.themeColor.iconButtonColor,),
          ),
            appBar: AppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(onPressed: (){
                  Scaffold.of(context).openDrawer();
                }, icon:  Icon(Icons.menu, size: 25, color: viewModel.themeColor.iconColor ));
              }
            ),
            title:const Center(
              child: Text("Progresso", style: TextStyle(fontFamily: "Pacifico", fontSize: 30, color: Color(0xFFE91E63) ),)
                ),
                actions: [
                  IconButton(onPressed: (){
                    viewModel.themeChanger();
                  }, icon: viewModel.darkTheme ? FaIcon(FontAwesomeIcons.moon, color: viewModel.themeColor.iconColor, size: 25,)
                  : FaIcon(FontAwesomeIcons.sun, color: viewModel.themeColor.iconColor, size: 25,)
                  ),
                  IconButton(
                        icon: Icon(
                          Icons.logout,
                          size: 25,
                          color: viewModel.themeColor.iconColor, 
                        ),
                        onPressed: () {
                          viewModel.fireBase_logOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreenView()), (route) => false);
                        }
                  )
                ], 
            backgroundColor: viewModel.themeColor.gradient1
            ),
            
          body:Container(
            height: double.infinity,
            width: double.infinity,
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  viewModel.themeColor.gradient1, // Dark gray
                  viewModel.themeColor.gradient2, // Dark blue-gray
                  viewModel.themeColor.gradient3, // Slightly purple-toned dark
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Padding(
                  padding:  const EdgeInsets.only(top:16.0, left: 8),
                  child: Text(
                    "Welcome, Ali Sultan", // Display the username
                    style:  TextStyle(
                      color: viewModel.themeColor.text1,
                      fontSize: 30,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      //letterSpacing: 2.0,
                    ),
                  ),
                ),
                 Padding(
                  padding: const  EdgeInsets.only(left:8.0),
                  child: Text("Have a great day", style: 
                  TextStyle(
                        color: viewModel.themeColor.text2,
                        fontFamily: "Montserrat",
                        fontSize: 15,
                  ),
                  ),
                ),
           const SizedBox(height: 10,),
            Divider(
            thickness: 5,
            color: viewModel.themeColor.text1,
           ),
           const SizedBox(height: 20,),
            Padding(
             padding: EdgeInsets.only(left: 8.0),
             child: Text("Your Tasks", style: TextStyle(fontSize: 25, color: viewModel.themeColor.text1,  fontFamily: "Poppins"),),
           ),
           const SizedBox(height: 10,),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  var userData = snapshot.data!.data() as Map<String, dynamic>?;
            
                  // Handle null or missing 'tasks' field
                  List<dynamic> tasks = userData?["tasks"] ?? [];
            
                  if (tasks.isEmpty) {
                    return  Center(
                      child: Text(
                        "No tasks available. Add some!",
                        style: TextStyle(color: viewModel.themeColor.text1),
                      ),
                    );
                  }
            
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> task = tasks[index] as Map<String, dynamic>;
            
                      return Card(
                        color: index % 2 == 0
                      ? viewModel.themeColor.tileColor1 // Soft dark gray
                      : viewModel.themeColor.tileColor2,
                        child: Slidable(
                           endActionPane: ActionPane(motion: const ScrollMotion(), 
                    children: [
                   
                    SlidableAction(onPressed: (context){
                      viewModel.isAdd = false;
                      viewModel.title.text = task["title"];
                      viewModel.description.text = task["description"];
                      viewModel.currentTask = task;
                      viewModel.customAlertDialog(context);
                    },
                    backgroundColor: viewModel.themeColor.iconColor, // Cyan for Edit
                    foregroundColor: Colors.white, // Dark base for the icon
                    icon: FontAwesomeIcons.penToSquare,
                    label: 'Edit',
                    ),
          
                     SlidableAction(onPressed: (context) async {
                      await viewModel.removeTask(task);
                     },
                    backgroundColor: viewModel.themeColor.statustext, // Crimson for Delete
                    foregroundColor: Colors.white, // White for the icon and text
                    icon: FontAwesomeIcons.trashCan,
                    label: 'Delete',
                    ),
                    ]),
                          child: ListTile(
                            key: ValueKey(task["id"] ?? task["title"]),
                            leading: Text("${index +1}", style:  TextStyle(color: viewModel.themeColor.iconColor, fontSize: 15),),
                            title: Text(
                              "${task["title"]}",
                              style:  TextStyle(color: viewModel.themeColor.text1),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${task["description"]}",
                                  style:  TextStyle(color: viewModel.themeColor.text3),
                                ),
                                
                                Row(
                                  children: [
                                    Text(
                                      "Status: ",
                                      style:  TextStyle(color: viewModel.themeColor.statustext,
                                      fontSize: 12
                                      ),
                                    ),
                                    Text(
                                      "${task["isChecked"]}",
                                      style:  TextStyle(color: viewModel.themeColor.text3 , fontSize: 12)
                                      ,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                            onPressed: () async {
                              await viewModel.toggleTaskCheckbox(task, context);
                            },
                            icon: task["isChecked"] == "Completed"
                              ?  FaIcon(
                                  FontAwesomeIcons.circleCheck,
                                  color: viewModel.themeColor.text2,
                                )
                              :  FaIcon(
                                  FontAwesomeIcons.circle,
                                  color: viewModel.themeColor.text2,
                                ),
                          )
           
                          ),
                        ),
                      );
                    },
                  );
                }
            
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(
                    child: CircularProgressIndicator(color: viewModel.themeColor.text1),
                  );
                }
            
                return  Center(
                  child: Text(
                    "Error loading tasks. Please try again.",
                    style: TextStyle(color: viewModel.themeColor.text1),
                  ),
                );
              },
            ),
          ),
                  ],
                ),
              ),
            ),
          ),        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                    backgroundColor: viewModel.themeColor.gradient1,
                    currentIndex: viewModel.selectedIndex,
                    selectedItemColor: viewModel.themeColor.text2,
                    unselectedItemColor: viewModel.themeColor.text3,
                    onTap: viewModel.onItemTapped,
                  ),
          ),
    );

      },
    );
  }
}
