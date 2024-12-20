import 'package:flutter/material.dart';

class CategoryNameBottomSheet extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 200,
      decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.elliptical(14, 23))),
      // color: Colors.black,
      child: Column(
        children: [
          Text(
            'Enter Category Name',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          TextField(
            controller: _controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Category name',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle the category name input, save it or use it
              Navigator.pop(context);
            },
            child: Text('Save Category', style: TextStyle(color: Colors.black)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          ),
        ],
      ),
    );
  }
}
