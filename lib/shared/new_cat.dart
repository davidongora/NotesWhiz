import 'package:flutter/material.dart';
import 'package:notes/Notes/new_notes.dart';
import 'package:notes/shared/bottom_sheet.dart';

class NewCategoryBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 300,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(26),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: Colors.grey[850],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(24)),
          ExpansionTile(
            title: Text(
              'Create New Notes category',
              style: TextStyle(color: Colors.white),
            ),
            children: [
              ListTile(
                title: Text(
                  'Create a new category',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Show another bottom sheet to enter the category name
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => CategoryNameBottomSheet(),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Create new Notes',
              style: TextStyle(color: Colors.white),
            ),
            children: [
              ListTile(
                title: Text(
                  'Add Notes ',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navigate to a new screen to add the notes
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WriteNotesScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
