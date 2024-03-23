import 'package:flutter/material.dart';
import 'package:est/widgets/common_screen.dart';

class TreesAddModalScreen extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _countController = TextEditingController();
  TextEditingController _dateController = TextEditingController(); // Add controller for date input

  @override
  Widget build(BuildContext context) {
    // Initialize the date controller with today's date
    _dateController.text = _formatDate(DateTime.now());

    return CommonScreen(
      title: 'Add Tree',
      showFAB: false,
      body: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Add Tree Category',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Tree Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _dateController,
                  readOnly: true, // Make the text field read-only
                  onTap: () async {
                    // Show date picker when the text field is tapped
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      // Update the text field with the selected date
                      _dateController.text = _formatDate(pickedDate); // Format the date
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today), // Add icon to indicate date picker
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _countController,
                  decoration: InputDecoration(
                    labelText: 'Count',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              // Add buttons for adding and editing workers
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Implement the logic to add a worker
                    // You can access the entered data using controller.text
                  },
                  child: Text('Add Tree'),
                ),
              ),
            ],
          ),
    );
  }

  // Helper function to format the date as a string
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
