// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/Notes/notes.dart';
import 'package:notes/Notes/todo.dart';
import 'package:notes/profile/edit_profile.dart';
import 'package:notes/profile/my_profile.dart';
import 'package:notes/shared/notes_card.dart';
import 'package:notes/shared/task.dart';

class Home extends StatefulWidget {
  final Map<String, dynamic> user;

  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(
                context); // This will pop the current screen and go back to the previous one
          },
        ),
      ),
      backgroundColor: Colors.black, // Black background for the screen
      body: MyWidget(user: widget.user),
      // floatingActionButton: FloatingActionButton(

      //   onPressed: () {
      //     print('floating action button');
      //   },
      // ),
    );
  }
}

List getTasks(String email) {
  var userBox = Hive.box(email);
  return userBox.get('tasks', defaultValue: []);
}

void printer() {
  var db = Hive.box('userDetails');
  var mytasks = db.get('emails');

  print('this are the tasks $mytasks');
}

class MyWidget extends StatefulWidget {
  final Map<String, dynamic> user;

  const MyWidget({super.key, required this.user});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late String username;
  late String email;
  // List tasks = [];
  int taskcount = 0;
  int notescount = 0;
  int completed = 0;
  double percentage_completed = 0;
  String? profileImagePath;
  late Box tasksBox;
  var motivation = 'Keep up the progress!';
  var addTasks = 'Add Tasks to measure your performance!';

  var tasks = <Map<String, dynamic>>[];
  var notes = <Map<String, dynamic>>[];

  void percentage() {
    setState(() {
      percentage_completed = completed / taskcount * 100;
    });
  }

  @override
  void initState() {
    super.initState();
    Hive.openBox('userDetails');
    username = widget.user['name'];
    email = widget.user['email'];
    _loadTasks();
    setState(() {
      // profileImagePath = widget.user['profileImage'];
    });

    email = widget.user['email'];
    fetchTasksAndNotes();
  }

  bool isChecked = false; // State to track the checkbox value

  Future<void> _loadTasks() async {
    // Open the user's tasks box using their email
    tasksBox = await Hive.openBox('${email}_tasks');

    setState(() {
      notes = tasksBox.values
          .map((task) => Map<String, dynamic>.from(task))
          .toList();
    });
    // Fetch all tasks from the box
    setState(() {
      tasks = tasksBox.values
          .map((task) => Map<String, dynamic>.from(task))
          .toList();
    });
  }

  Future<void> _updateTaskCompletion(String key, bool completed) async {
    // Update task completion status in the Hive box
    final task = Map<String, dynamic>.from(tasksBox.get(key));
    task['completed'] = completed;
    await tasksBox.put(key, task);

    // Refresh the tasks list
    _loadTasks();
  }

  void fetchTasksAndNotes() async {
    // var userBox = Hive.box(email);
    var userBox = await Hive.openBox('userDetails');

    // Fetch tasks
    tasks = userBox.get('${email}_tasks');
    notes = userBox.get('${email}_notes');

    taskcount = tasks.length;

    // notescount = userBox.get('${email}_notes', defaultValue: []).length;

    setState(() {}); // Refresh UI after data is fetched
    print(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hello $username',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text for dark background
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.notifications_active,
                          color: Colors.white, size: 28),
                      const SizedBox(width: 16),
                      GestureDetector(
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey,
                          // child: profileImagePath != null
                          //     ? Image.asset('profileImage')
                          //     : Image.asset('assets/rb_377.png'),
                          // (Icons.person, color: Colors.black),
                        ),
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyProfile(user: widget.user)
                                  // EditMyProfile(user: widget.user)
                                  ))
                        },
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Today's Progress Section
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[850], // Dark grey background for the card
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6.0,
                      offset: Offset(0, 3), // Elevation shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    // Row for Title and Progress Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Today\'s Progress',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white, // White text
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 24,
                          child: Text(
                            '$percentage_completed%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    tasks.isEmpty
                        ? Text(
                            'You have completed ${tasks.where((task) => task['completed'] == true).length} of ${tasks.length} tasks, $addTasks',
                            style: const TextStyle(
                              fontSize: 16,
                              color:
                                  Colors.white70, // Slightly faded white text
                            ),
                          )
                        : Text(
                            'You have completed ${tasks.where((task) => task['completed'] == true).length} of ${tasks.length} tasks, $motivation',
                            style: const TextStyle(
                              fontSize: 16,
                              color:
                                  Colors.white70, // Slightly faded white text
                            ),
                          ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Row(children: [
                GestureDetector(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                        children: [
                          ReusableCard(
                              icon: Icons.note_add_sharp,
                              title: 'Notes',
                              subtitle: '${notes.length} Notes',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NotesPage(email: email)));
                              }),
                          const SizedBox(
                            width: 16,
                          ),
                          ReusableCard(
                              icon: Icons.note_add_sharp,
                              title: 'Todo List',
                              subtitle: '${tasks.length} Tasks',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            todos(email: email)));
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        const Text(
                          'Pending Tasks',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 180,
                        ),
                        tasks.isEmpty
                            ? const Text(
                                'No tasks',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              )
                            : const Text(
                                'See All',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      tasks.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    'No tasks available!',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize:
                                          16, // Optional: Adjust font size as needed
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Image.asset(
                                      height: 300, width: 300, 'assets/rb.png')
                                ],
                              ),
                            )
                          : Container(
                              height: 400,
                              width: 360,
                              child: ListView.builder(
                                itemCount: tasks.length,
                                itemBuilder: (context, index) {
                                  final taskKey =
                                      tasksBox.keyAt(index); // Key for Hive box
                                  final task = tasks[index]; // Task details

                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    padding: const EdgeInsets.all(16.0),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .grey[850], // Dark grey background
                                      borderRadius: BorderRadius.circular(12.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black54,
                                          blurRadius: 6.0,
                                          offset:
                                              Offset(0, 3), // Elevation shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Row for Title and Checkbox
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              task['title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color:
                                                    Colors.white, // White text
                                              ),
                                            ),
                                            // Checkbox(
                                            //   value: task['completed'],
                                            //   onChanged: (bool? value) {
                                            //     if (value != null) {
                                            //       _updateTaskCompletion(
                                            //           taskKey, value);
                                            //     }
                                            //   },
                                            //   activeColor: Colors.blue,
                                            //   checkColor: Colors.white,
                                            // ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),

                                        // Task Description
                                        Text(
                                          task['description'] ??
                                              'No description available.',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors
                                                .white70, // Slightly faded white text
                                          ),
                                        ),

                                        // Task Created At
                                        const SizedBox(height: 10),
                                        // Text(
                                        //   'Created: ${task['createdAt']}',
                                        //   style: const TextStyle(
                                        //     fontSize: 12,
                                        //     color: Colors
                                        //         .white54, // Faded white text
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                    ]))
              ])
            ]));
  }
}
