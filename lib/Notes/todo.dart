import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes/profile/my_profile.dart';
import 'package:notes/shared/buttons.dart';

class Task {
  String title;
  String description;

  Task({required this.title, required this.description});
}

class todos extends StatefulWidget {
  const todos({super.key, required this.email});
  final String email;

  @override
  State<todos> createState() => _todosState();
}

class _todosState extends State<todos> {
  late Box taskBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box('${widget.email}_tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Todos',
          style: TextStyle(color: Colors.white),
        ),
        // actions: [
        // const Icon(Icons.notifications_active, color: Colors.white, size: 28),
        // const SizedBox(width: 16),
        // GestureDetector(
        // onTap: () {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => MyProfile(user: user)));
        // },
        //   child: const CircleAvatar(
        //     radius: 24,
        //     backgroundColor: Colors.grey,
        //     child: Icon(Icons.person, color: Colors.black),
        //   ),
        // )
        // ],
      ),
      body: todosMyWidget(email: widget.email),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          backgroundColor: Colors.grey[900],
          context: context,
          builder: (context) => AddTaskBottomSheet(email: widget.email),
        ),
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class todosMyWidget extends StatefulWidget {
  const todosMyWidget({super.key, required this.email});
  final String email;

  @override
  State<todosMyWidget> createState() => _todosMyWidgetState();
}

class _todosMyWidgetState extends State<todosMyWidget> {
  late Box taskBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box('${widget.email}_tasks');
  }

  @override
  Widget build(BuildContext context) {
    final tasks = taskBox.values.toList();

    return tasks.isEmpty
        ? const Center(
            child: Text(
              'No tasks available!',
              style:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskCard(
                title: task['title'] ?? 'Untitled',
                description: task['description'] ?? 'No description available',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(
                      email: widget.email,
                      taskKey: taskBox.keyAt(index),
                      task: task,
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const TaskCard({
    required this.title,
    required this.description,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.grey[850],
      child: ListTile(
        title: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(color: Colors.white70),
        ),
        onTap: onTap,
      ),
    );
  }
}

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key, required this.email});
  final String email;

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late Box taskBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box('${widget.email}_tasks');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.blue),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.white), // Input text color

              validator: (value) =>
                  value!.isEmpty ? 'Title cannot be empty' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.blue),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.white), // Input text color

              validator: (value) =>
                  value!.isEmpty ? 'Description cannot be empty' : null,
            ),
            const SizedBox(height: 16),
            Buttons(
              onPressed: () {
                taskBox = Hive.box('${widget.email}_tasks');
                setState(() {
                  taskBox = Hive.box('${widget.email}_tasks');
                });
                if (_formKey.currentState!.validate()) {
                  taskBox.add({
                    'title': _titleController.text,
                    'description': _descriptionController.text,
                  });
                  Navigator.pop(context);
                  setState(() {});
                }
              },
              buttonText: 'Add Task',
              // child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditTaskScreen extends StatefulWidget {
  final String email;
  final dynamic taskKey;
  final Map task;

  const EditTaskScreen({
    required this.email,
    required this.taskKey,
    required this.task,
    super.key,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late Box taskBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box('${widget.email}_tasks');
    _titleController = TextEditingController(text: widget.task['title']);
    _descriptionController =
        TextEditingController(text: widget.task['description']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Edit Task',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) =>
                    value!.isEmpty ? 'Title cannot be empty' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) =>
                    value!.isEmpty ? 'Description cannot be empty' : null,
              ),
              const SizedBox(height: 36),
              Buttons(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    taskBox.put(widget.taskKey, {
                      'title': _titleController.text,
                      'description': _descriptionController.text,
                    });
                    Navigator.pop(context);
                  }
                },
                buttonText: 'Save Changes',
                // child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
