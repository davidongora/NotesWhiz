import 'package:flutter/material.dart';

class TasksCard extends StatefulWidget {
  const TasksCard({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  _TasksCardState createState() => _TasksCardState();
}

class _TasksCardState extends State<TasksCard> {
  bool isChecked = false; // Local state for the checkbox

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
        children: [
          // Row for Title and Progress Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title, // Use the passed title
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white, // White text
                ),
              ),
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked =
                        value ?? false; // Update the state for this card
                  });
                },
                activeColor: Colors.blue, // Custom active color
                checkColor: Colors.white, // Color of the check icon
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.description, // Use the passed description
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70, // Slightly faded white text
            ),
          ),
        ],
      ),
    );
  }
}
