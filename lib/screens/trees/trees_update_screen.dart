import 'package:flutter/material.dart';
import 'package:est/widgets/common_screen.dart';

class TreesUpdateModalScreen extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _countController = TextEditingController();
  TextEditingController _dateController =
      TextEditingController(); // Add controller for date input

  @override
  Widget build(BuildContext context) {
    // Initialize the date controller with today's date
    _dateController.text = _formatDate(DateTime.now());

    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: Text('Update Tree'),
      content: Container(
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.2 + 30,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _countController,
                        decoration: new InputDecoration(
                          labelText: 'Count',
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {

                              },
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors
                                        .white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.grey,
                                elevation: 5,
                                padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {

                              },
                              child: Text(
                                'Minus',
                                style: TextStyle(
                                    color: Colors
                                        .white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.grey,
                                elevation: 5,
                                padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8),
                                ),
                              ),
                            ),
                          ]),
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
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
