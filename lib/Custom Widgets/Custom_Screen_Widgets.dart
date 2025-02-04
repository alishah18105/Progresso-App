import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoist/Screens/Home%20Screen/homeScreen_viewModlel.dart';

class Todo extends StatelessWidget {
  final HomeScreenViewModel viewModel;
  const Todo({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
            height: double.infinity,
            width: double.infinity,
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
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Padding(
                  padding:  const EdgeInsets.only(top:16.0, left: 8),
                  child: Text(
                    "Welcome, ${viewModel.userName}", // Display the username
                    style:  TextStyle(
                      color: themeColor.text1,
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
                        color: themeColor.text2,
                        fontFamily: "Montserrat",
                        fontSize: 15,
                  ),
                  ),
                ),
           const SizedBox(height: 10,),
            Divider(
            thickness: 5,
            color: themeColor.text1,
           ),
           const SizedBox(height: 20,),
            Padding(
             padding: EdgeInsets.only(left: 8.0),
             child: Text("Your Tasks", style: TextStyle(fontSize: 25, color: themeColor.text1,  fontFamily: "Poppins"),),
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
                        style: TextStyle(color: themeColor.text1),
                      ),
                    );
                  }
            
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> task = tasks[index] as Map<String, dynamic>;
            
                      return Card(
                        color: index % 2 == 0
                      ? themeColor.tileColor1 // Soft dark gray
                      : themeColor.tileColor2,
                        child: Slidable(
                           endActionPane: ActionPane(motion: const ScrollMotion(), 
                    children: [
                   
                    SlidableAction(onPressed: (context){
                      viewModel.isAdd = false;
                      viewModel.title.text = task["title"];
                      viewModel.description.text = task["description"];
                       viewModel.date.text = task["date"];
                       viewModel.time.text = task ["time"];
                      viewModel.currentTask = task;
                      viewModel.customAlertDialog(context);
                    },
                    backgroundColor: themeColor.iconColor, // Cyan for Edit
                    foregroundColor: Colors.black, // Dark base for the icon
                    icon: FontAwesomeIcons.penToSquare,
                    label: 'Edit',
                    ),
          
                     SlidableAction(onPressed: (context) async {
                      await viewModel.removeTask(task);
                     },
                    backgroundColor: themeColor.statustext, // Crimson for Delete
                    foregroundColor: themeColor.iconButtonColor, // White for the icon and text
                    icon: FontAwesomeIcons.trashCan,
                    label: 'Delete',
                    ),
                    ]),
                          child: GestureDetector(
                            onTap: (){
                              viewModel.isAdd = false;
                              viewModel.title.text = task["title"];
                              viewModel.description.text = task["description"];
                              viewModel.date.text = task["date"];
                              viewModel.time.text = task ["time"];
                              viewModel.currentTask = task;
                              viewModel.customAlertDialog(context);
                                    },
                            child: ListTile(
                              key: ValueKey(task["id"] ?? task["title"]),
                              leading: Text("${index +1}", style:  TextStyle(color: themeColor.iconColor, fontSize: 15),),
                              title: Text(
                                "${task["title"]}",
                                style:  TextStyle(color: themeColor.text1),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    task["description"].length > 16
                                    ? "${task["description"].substring(0, 16)}..."
                                    : task["description"],
                                    style:  TextStyle(color: themeColor.text3, fontSize: 12),
                                  ),
                                  
                                  Row(
                                    children: [
                                      Text(
                                        "Status: ",
                                        style:  TextStyle(color: themeColor.statustext,
                                        fontSize: 10
                                        ),
                                      ),
                                      Text(
                                        "${task["isChecked"]}",
                                        style:  TextStyle(color: themeColor.text3 , fontSize: 10)
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
                                    color: themeColor.text2,
                                  )
                                :  FaIcon(
                                    FontAwesomeIcons.circle,
                                    color: themeColor.text2,
                                  ),
                            )
                                       
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
            
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(
                    child: CircularProgressIndicator(color: themeColor.text1),
                  );
                }
            
                return  Center(
                  child: Text(
                    "Error loading tasks. Please try again.",
                    style: TextStyle(color: themeColor.text1),
                  ),
                );
              },
            ),
          ),
                  ],
                ),
              ),
            ),
          )   ;
  }
}

class Notepad extends StatelessWidget {
  final HomeScreenViewModel viewModel;
  const Notepad({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
            height: double.infinity,
            width: double.infinity,
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
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Padding(
                  padding:  const EdgeInsets.only(top:16.0, left: 8),
                  child: Text(
                    "Welcome, ${viewModel.userName}", // Display the username
                    style:  TextStyle(
                      color: themeColor.text1,
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
                        color: themeColor.text2,
                        fontFamily: "Montserrat",
                        fontSize: 15,
                  ),
                  ),
                ),
           const SizedBox(height: 10,),
            Divider(
            thickness: 5,
            color: themeColor.text1,
           ),
           const SizedBox(height: 20,),
            Padding(
             padding: EdgeInsets.only(left: 8.0),
             child: Text("Notepad", style: TextStyle(fontSize: 25, color: themeColor.text1,  fontFamily: "Poppins"),),
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
                  List<dynamic> notes = userData?["notes"] ?? [];
            
                  if (notes.isEmpty) {
                    return  Center(
                      child: Text(
                        "No Notes available. Add some!",
                        style: TextStyle(color: themeColor.text1),
                      ),
                    );
                  }
            
                  return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> note = notes[index] as Map<String, dynamic>;
            
                      return Card(
                        color: index % 2 == 0
                      ? themeColor.tileColor1 // Soft dark gray
                      : themeColor.tileColor2,
                        child: Slidable(
                           endActionPane: ActionPane(motion: const ScrollMotion(), 
                    children: [
                   
                    SlidableAction(onPressed: (context){
                      viewModel.isAdd = false;
                       viewModel.titleNotepad.text = note["title"];
                      viewModel.detail.text = note["description"];
                      viewModel.dateNotepad.text = note["date"];
                      viewModel.curentNote = note;
                      viewModel.customAlerNoteDialog(context);
                    },
                    backgroundColor: themeColor.iconColor, // Cyan for Edit
                    foregroundColor: Colors.black, // Dark base for the icon
                    icon: FontAwesomeIcons.penToSquare,
                    label: 'Edit',
                    ),
          
                     SlidableAction(onPressed: (context) async {
                      await viewModel.removeNote(note);
                     },
                    backgroundColor: themeColor.statustext, // Crimson for Delete
                    foregroundColor: themeColor.iconButtonColor, // White for the icon and text
                    icon: FontAwesomeIcons.trashCan,
                    label: 'Delete',
                    ),
                    ]),
                          child: GestureDetector(
                            onTap: (){
                              viewModel.isAdd = false;
                               viewModel.titleNotepad.text = note["title"];
                               viewModel.detail.text = note["description"];
                                 viewModel.dateNotepad.text = note["date"];
                                viewModel.curentNote = note;
                                viewModel.customAlerNoteDialog(context);
                            },
                            child: ListTile(
                              key: ValueKey(note["id"] ?? note["title"]),
                              leading: Text("${index +1}", style:  TextStyle(color: themeColor.iconColor, fontSize: 15),),
                              title: Text(
                                "${note["title"]}",
                                style:  TextStyle(color: themeColor.text1),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 Text(
                                note["description"].length > 25
                                    ? "${note["description"].substring(0, 20)}..."
                                    : note["description"],
                                style: TextStyle(color: themeColor.text3, fontSize: 12),
                              ),
                                  
                                  Row(
                                    children: [
                                        FaIcon(FontAwesomeIcons.calendar,color: themeColor.statustext, size: 14),
                                        SizedBox(width: 5,),
                                      Text(
                                        "${note["date"]}",
                                        style:  TextStyle(color: themeColor.text3 , fontSize: 12)
                                        ,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                             
                                       
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
            
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(
                    child: CircularProgressIndicator(color: themeColor.text1),
                  );
                }
            
                return  Center(
                  child: Text(
                    "Error loading tasks. Please try again.",
                    style: TextStyle(color: themeColor.text1),
                  ),
                );
              },
            ),
          ),
                  ],
                ),
              ),
            ),
          )   ;
  }
}



