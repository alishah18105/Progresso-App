import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:todoist/Utilis/app_colors.dart';

bool darkTheme = true;
ThemeBase themeColor = DarkTheme();

class HomeScreenViewModel extends BaseViewModel {
  //Todo Screen
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();

//Notepad Screen
  TextEditingController titleNotepad = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController dateNotepad = TextEditingController();
  


  String? userName; 
  Map<String, dynamic>? currentTask; 
  List<Map<String, dynamic>> tasks = []; 

  Map<String, dynamic> ? curentNote;
  List <Map<String,dynamic>> notes = []; 

  bool isAdd = true;

  
  Future<DocumentReference> get userDoc async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("No user is currently logged in.");
    }
    return FirebaseFirestore.instance.collection("users").doc(user.uid);
  }

  // Fetch tasks for the current user
  Future<void> fetchTasks() async {
    try {
      final userDocument = await userDoc;
      final snapshot = await userDocument.get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        tasks = List<Map<String, dynamic>>.from(data['tasks'] ?? []);
        notes = List<Map<String, dynamic>>.from(data["notes"] ?? []);
        userName = data['name']?? "User" as String?;
        print("Fetched tasks: $tasks");
      } else {
        print("No user data found in Firestore.");
        tasks = [];
        notes = [];
      }
      notifyListeners(); // Update UI
    } catch (error) {
      print("Error fetching tasks: $error");
    }
  }

  // Add a new task to the user's tasks array
  Future<void> addTask() async {
    try {
      final userDocument = await userDoc;

      Map<String, String> newTask = {
        "title": title.text.trim(),
        "description": description.text.trim(),
        "date" : date.text.trim(),
        "time" : time.text.trim(),
        "isChecked" : "Pending"
      };

      await userDocument.update({
        "tasks": FieldValue.arrayUnion([newTask])
      });

      // Update local tasks list
      tasks.add(newTask);
      title.clear();
      description.clear();
      date.clear();
      time.clear();
      print("Task added successfully!");
      notifyListeners(); // Update UI
    } catch (error) {
      print("Error adding task: $error");
    }
  }

  Future<void> addNotes() async {
    try {
      final userDocument = await userDoc;

      Map<String, String> newNote = {
        "title": titleNotepad.text.trim(),
        "description": detail.text.trim(),
        "date" : dateNotepad.text.trim(),
      };

      await userDocument.update({
        "notes": FieldValue.arrayUnion([newNote])
      });

      // Update local tasks list
      notes.add(newNote);
      titleNotepad.clear();
      detail.clear();
      dateNotepad.clear();
      print("Note added successfully!");
      notifyListeners(); 
    } catch (error) {
      print("Error adding Notes: $error");
    }
  }

  // Update an existing task
  Future<void> updateTask() async {
    if (currentTask == null) {
      print("Current task is null. Please ensure you're editing a task.");
      return;
    }

    try {
      final userDocument = await userDoc;

      // Remove the old task first
      await userDocument.update({
        "tasks": FieldValue.arrayRemove([currentTask])
      });

      // Add the updated task
      Map<String, String> updatedTask = {
        "title": title.text.trim(),
        "description": description.text.trim(),
        "date" : date.text.trim(),
        "time" : time.text.trim(),
        "isChecked" : "Pending",
      };

      await userDocument.update({
        "tasks": FieldValue.arrayUnion([updatedTask])
      });

      // Update local tasks list
      tasks.remove(currentTask);
      tasks.add(updatedTask);

      title.clear();
      description.clear();
      date.clear();
      time.clear();
      currentTask = null; // Clear the current task after updating
      print("Task updated successfully!");
      notifyListeners(); // Update UI
    } catch (error) {
      print("Error updating task: $error");
    }
  }

Future<void> updateNote() async {
    if (curentNote == null) {
      print("Current Note is null. Please ensure you're editing a note.");
      return;
    }

    try {
      final userDocument = await userDoc;

      // Remove the old task first
      await userDocument.update({
        "notes": FieldValue.arrayRemove([curentNote])
      });

      // Add the updated task
      Map<String, String> updatedNote = {
        "title": titleNotepad.text.trim(),
        "description": detail.text.trim(),
        "date" : dateNotepad.text.trim(),
      };

      await userDocument.update({
        "notes": FieldValue.arrayUnion([updatedNote])
      });

      // Update local tasks list
      notes.remove(curentNote);
      notes.add(updatedNote);

      titleNotepad.clear();
      detail.clear();
      date.clear();
      curentNote = null; // Clear the current task after updating
      print("Note updated successfully!");
      notifyListeners(); // Update UI
    } catch (error) {
      print("Error updating task: $error");
    }
  }

  // Remove a task from the user's tasks array
  Future<void> removeTask(Map<String, dynamic> task) async {
    try {
      final userDocument = await userDoc;

      await userDocument.update({
        "tasks": FieldValue.arrayRemove([task])
      });

      // Update local tasks list
      tasks.remove(task);
      print("Task removed successfully!");
      notifyListeners(); // Update UI
    } catch (error) {
      print("Error removing task: $error");
    }
  }

   Future<void> removeNote(Map<String, dynamic> note) async {
    try {
      final userDocument = await userDoc;

      await userDocument.update({
        "notes": FieldValue.arrayRemove([note])
      });

      // Update local tasks list
      notes.remove(note);
      print("Note removed successfully!");
      notifyListeners(); // Update UI
    } catch (error) {
      print("Error removing task: $error");
    }
  }

  // Load the current user ID and fetch tasks
  Future<void> loadUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print("Current User ID: ${user.uid}");
        await fetchTasks(); // Fetch tasks for the current user
      } else {
        print("No user is currently logged in.");
      }
    } catch (error) {
      print("Error loading user data: $error");
    }
  }

  // Custom alert dialog for adding or updating tasks
  void customAlertDialog(BuildContext context) {
  DateTime selectedDate = DateTime.now(); // Default to the current date
  TimeOfDay? selectedEndTime;
  

Future<void> pickDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime.now(), // Prevent selecting past dates
    lastDate: DateTime(2100),
  );
  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
    date.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    notifyListeners(); // Notify UI to update
  }
}

// Function to pick an end time
Future<void> pickEndTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (picked != null && picked != selectedEndTime) {
    selectedEndTime = picked;
    time.text =
        "${selectedEndTime!.hour}:${selectedEndTime!.minute.toString().padLeft(2, '0')}";
    notifyListeners(); // Notify UI to update
  }
}

showDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: themeColor.tileColor1,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(isAdd ? "Add Task" : "Update Task", style: TextStyle(color: themeColor.text1, ),),
          IconButton(onPressed: (){
            title.clear();
            description.clear();
            date.clear();
            time.clear();
            Navigator.pop(context);
          }, icon: Icon(Icons.cancel,color:  themeColor.elevatedButtonColor, size: 30))
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            style: TextStyle(color: themeColor.startText3),
            controller: title,
            decoration:  InputDecoration(labelText: "Title",labelStyle: TextStyle(color: themeColor.dialogFieldText)),
          ),
          TextField(
            style: TextStyle(color: themeColor.startText3),
            controller: description,
            decoration:  InputDecoration(labelText: "Description", labelStyle: TextStyle(color: themeColor.dialogFieldText)),
          ),
          const SizedBox(height: 10),
          // Date Picker
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: themeColor.startText3),
                  readOnly: true,
                  controller: date, 
                  decoration:  InputDecoration(
                    labelText: "Submission Date",
                    labelStyle: TextStyle(color: themeColor.dialogFieldText)
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await pickDate(context);
                },
                icon:  FaIcon(FontAwesomeIcons.calendar, color: themeColor.dialogIconColor,),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // End Time Picker
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: themeColor.startText3),
                  readOnly: true,
                  controller: time, // Use existing TextEditingController
                  decoration:  InputDecoration(
                    labelText: "End Time",
                    labelStyle: TextStyle(color: themeColor.dialogFieldText)
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await pickEndTime(context);
                },
                icon: FaIcon(FontAwesomeIcons.clock, color: themeColor.dialogIconColor,),
              ),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (isAdd) {
              
              await addTask();
            } else {
              
              await updateTask();
            }
            title.clear();
            description.clear();
            date.clear();
            time.clear();
            Navigator.pop(context);
          },
          child: Text(isAdd ? "Add" : "Update", style: TextStyle(color:themeColor.iconButtonColor),),
          style: ElevatedButton.styleFrom(
                backgroundColor: themeColor.elevatedButtonColor,
          ),
        ),
      ],
    );
  },
);

}

void customAlerNoteDialog(BuildContext context) {
  DateTime selectedDate = DateTime.now();
   

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateNotepad.text =
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    }
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: themeColor.tileColor1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isAdd ? "Add Note" : "Update Note",
              style: TextStyle(color: themeColor.text1, fontWeight: FontWeight.bold),
            ),
             IconButton(onPressed: (){
              titleNotepad.clear();
                detail.clear();
                dateNotepad.clear();
            Navigator.pop(context);
          }, icon: Icon(Icons.cancel,color:  themeColor.elevatedButtonColor, size: 30))
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title TextField
              TextField(
                style: TextStyle(color: themeColor.startText3),
                controller: titleNotepad,
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: themeColor.dialogFieldText),
                ),
              ),
          
              const SizedBox(height: 10), // Added spacing
          
              // Details TextField
              TextField(
                style: TextStyle(color: themeColor.startText3),
                controller: detail,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Note something down",
                  hintStyle: TextStyle(color: themeColor.dialogFieldText),
                  alignLabelWithHint: true, // Ensures hint stays on top-left
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: themeColor.elevatedButtonColor)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: themeColor.elevatedButtonColor)
                  ),
                ),
              ),
          
              const SizedBox(height: 10),
          
              // Date Picker Row
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: themeColor.startText3),
                      readOnly: true,
                      controller: dateNotepad,
                      decoration: InputDecoration(
                        labelText: "Added On",
                        labelStyle: TextStyle(color: themeColor.dialogFieldText),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await pickDate(context);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.calendar,
                      color: themeColor.dialogIconColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (isAdd) {
                await addNotes();
                
              } else {
                await updateNote();
              }
              titleNotepad.clear();
                detail.clear();
                dateNotepad.clear();
              Navigator.pop(context);
            },
            child: Text(
              isAdd ? "Add" : "Update",
              style: TextStyle(color: themeColor.iconButtonColor),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColor.elevatedButtonColor,
            ),
          ),
        ],
      );
    },
  );
}




  //Bottom Navigation Bar:
  int selectedIndex = 0;
  void onItemTapped(int index) {
      selectedIndex = index;
      notifyListeners();
    
  }

  // Update checkbox value for a specific task
Future<void> toggleTaskCheckbox(Map<String, dynamic> task, BuildContext context) async {
  try {
    // Toggle the isChecked value (no change in task order)
    Map<String, dynamic> updatedTask = {
      ...task,
      "isChecked": task["isChecked"] == "Completed" ? "Pending" : "Completed",
    };

    // Update the task in the local list
    int taskIndex = tasks.indexOf(task);
    if (taskIndex != -1) {
      tasks[taskIndex] = updatedTask;  // Only update the task's state (isChecked)
    }

    // Notify listeners to trigger a UI update
    notifyListeners();

    // Update the task in Firestore
    final userDocument = await userDoc;

    // Instead of removing and adding the task, we directly update it
    await userDocument.update({
      "tasks": FieldValue.arrayRemove([task]),  // Remove the old task
    });

    await userDocument.update({
      "tasks": FieldValue.arrayUnion([updatedTask]),  // Add the updated task
    });

    // Show a snackbar when the task is completed (checked)
    if (updatedTask["isChecked"] == "Completed") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task Completed Successfully!")),
      );
    }
  } catch (error) {
    print("Error toggling checkbox: $error");
  }
}

//Log Out Function: 
fireBase_logOut()async{
await FirebaseAuth.instance.signOut();

}

//Theme Changer

void themeChanger() {
  darkTheme = !darkTheme;
  themeColor = darkTheme ? DarkTheme() : LightTheme();
  notifyListeners();
}



}
