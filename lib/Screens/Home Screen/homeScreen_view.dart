import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
            child: const Icon(Icons.add),
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
            : const Color(0xFF4A90E2),
              child: ListTile(
              
                title: Text(
                  "${task["title"]}",
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  "${task["description"]}",
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFFFFA500),
                      child: IconButton(
                        onPressed: () {
                          viewModel.isAdd = false;
                          viewModel.title.text = task["title"];
                          viewModel.description.text = task["description"];
                          viewModel.currentTask = task;
                          viewModel.customAlertDialog(context);
                        },
                        icon: const Icon(Icons.edit, color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 10,),
                    CircleAvatar(
                      backgroundColor: Colors.redAccent[700],
                      child: IconButton(
                        onPressed: () async {
                          await viewModel.removeTask(task);
                        },
                        icon: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  ],
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
        );
      },
    );
  }
}
