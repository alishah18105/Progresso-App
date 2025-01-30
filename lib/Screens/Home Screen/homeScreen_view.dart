import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:todoist/Screens/Home%20Screen/homeScreen_viewModlel.dart';

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
            backgroundColor:const Color(0xFF40E0D0),
            child: const Icon(Icons.add),
          ),
            appBar: AppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(onPressed: (){
                  Scaffold.of(context).openDrawer();
                }, icon: const Icon(Icons.menu, size: 25, color:Color(0xFF40E0D0) ));
              }
            ),
            title:const Center(
              child: Text("Progresso", style: TextStyle(fontFamily: "Pacifico", fontSize: 30, color: Color(0xFFE91E63) ),)
                ), 
            backgroundColor: const Color(0xFF1C1F26)
            ),
            
          body:Container(
  height: double.infinity,
  width: double.infinity,
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
  child: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                  const Padding(
                  padding:  EdgeInsets.only(top:16.0, left: 8),
                  child: Text(
                    "Welcome, Ali Sultan", // Display the username
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: "BebasNeue",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.only(left:8.0),
                  child: Text("Have a great day", style: 
                  TextStyle(
                        color: Colors.white60,
                        fontFamily: "Montserrat",
                        fontSize: 15,
                  ),
                  ),
                ),
           const SizedBox(height: 10,),
           const Divider(
            thickness: 7,
           ),
           const SizedBox(height: 20,),
          const  Padding(
             padding: EdgeInsets.only(left: 8.0),
             child: Text("Your Tasks", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "Oswald"),),
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
                    return const Center(
                      child: Text(
                        "No tasks available. Add some!",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
            
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> task = tasks[index] as Map<String, dynamic>;
            
                      return Card(
                        color: index % 2 == 0
                      ? const Color(0xFF2F353D) // Soft dark gray
                      : const  Color(0xFF5E5A78),
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
                    backgroundColor: const Color(0xFF40E0D0), // Cyan for Edit
                    foregroundColor: const Color(0xFF1C1F26), // Dark base for the icon
                    icon: FontAwesomeIcons.penToSquare,
                    label: 'Edit',
                    ),

                     SlidableAction(onPressed: (context) async {
                      await viewModel.removeTask(task);
                     },
                    backgroundColor: const Color(0xFFB22222), // Crimson for Delete
                    foregroundColor: Colors.white, // White for the icon and text
                    icon: FontAwesomeIcons.trashCan,
                    label: 'Delete',
                    ),
                    ]),
                          child: ListTile(
                            key: ValueKey(task["id"] ?? task["title"]),
                            leading: Text("${index +1}", style: const TextStyle(color: Color(0xFF40E0D0), fontSize: 15),),
                            title: Text(
                              "${task["title"]}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${task["description"]}",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                
                                Row(
                                  children: [
                                    Text(
                                      "Status: ",
                                      style: const TextStyle(color: const Color(0xFFB22222)),
                                    ),
                                    Text(
                                      "${task["isChecked"]}",
                                      style: const TextStyle(color: Colors.white70),
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
                              ? const FaIcon(
                                  FontAwesomeIcons.circleCheck,
                                  color: Color(0xFF4A90E2),
                                )
                              : const FaIcon(
                                  FontAwesomeIcons.circle,
                                  color: Color(0xFF4A90E2),
                                ),
                          )
 
                          ),
                        ),
                      );
                    },
                  );
                }
            
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
            
                return const Center(
                  child: Text(
                    "Error loading tasks. Please try again.",
                    style: TextStyle(color: Colors.white),
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
                    backgroundColor: const Color(0xFF1C1F26),
                    currentIndex: viewModel.selectedIndex,
                    selectedItemColor:const Color(0xFF4A90E2),
                    unselectedItemColor: const Color(0xFF757C89),
                    onTap: viewModel.onItemTapped,
                  ),
          ),
    );

      },
    );
  }
}
