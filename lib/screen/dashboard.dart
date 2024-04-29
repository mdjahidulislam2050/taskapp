import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/widget/textField.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final taskController = TextEditingController();
  final descriptionController = TextEditingController();
  List<String> tasks = [];

  void addTask(String task, String description) {
    setState(() {
      tasks.add("$task: $description");
    });
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 65),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text(
                      'Task Management App',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue),
                    )
                  ],
                ),
                IconButton(
                    onPressed: (){
                      final auth = FirebaseAuth.instance;
                      auth.signOut();
                    },
                    icon: const Icon(Icons.logout)
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tasks[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Implement update functionality
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeTask(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => Center(
              child: SizedBox(
                width: 330,
                height: 400,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                    child: Column(
                      children: [
                        reusableTextFleid(
                          text: "task title",
                          isPasswordType: false,
                          controller: taskController,
                          icon: Icons.person,
                        ),
                        SizedBox(height: 10),
                        reusableTextFleid(
                          text: "Description",
                          isPasswordType: false,
                          controller: descriptionController,
                          maxLine: 5,
                          icon: Icons.details,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            addTask(
                              taskController.text,
                              descriptionController.text,
                            );
                            Navigator.pop(context);
                            taskController.clear();
                            descriptionController.clear();
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue[200],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.lightBlue,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
