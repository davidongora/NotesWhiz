import 'package:flutter/material.dart';

class WriteNotesScreen extends StatelessWidget {
  const WriteNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Write Notes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Write your notes here...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 56),
              ElevatedButton(
                onPressed: () {
                  // Handle saving the notes here
                },
                child: const Text('Save Note'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
