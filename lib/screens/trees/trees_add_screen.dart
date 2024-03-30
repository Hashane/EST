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

    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: Text('Add Tree'),
      content: Container(
        width: screenSize.width * 0.8, // Adjust width to 80% of screen width
        height: screenSize.height * 0.4 + 50,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Tree Name',
                          enabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
                            _dateController.text =
                                _formatDate(pickedDate); // Format the date
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Date',
                          enabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                              Icons.calendar_today), // Add icon to indicate date picker
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _countController,
                        decoration: new InputDecoration(
                          labelText: 'Count',
                          enabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 45),
                    // Add buttons for adding trees
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement the logic to add a worker
                          // You can access the entered data using controller.text
                        },
                        child: Text(
                          'Add Tree',
                          style: TextStyle(color: Colors.white), // Set text color to white
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey, // Set background color to grey
                          elevation: 5, // Add elevation for 3D effect
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Add padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Set border radius
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to format the date as a string
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day
        .toString().padLeft(2, '0')}';
  }
}
