import 'package:flutter/material.dart';
import 'package:est/widgets/common_screen.dart';
import 'package:est/models/expense_model.dart';

class ExpensesAddModal extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
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
      title: Text('Add Expense'),
      content: Container(
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.4,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _nameController,
                        decoration: new InputDecoration(
                          labelText: 'Name',
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
                      child: TextField(
                        controller: _priceController,
                        decoration: new InputDecoration(
                          labelText: 'Price',
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
                      child: ElevatedButton(
                        onPressed: () { _addExpenseToFirestore(context); },
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          elevation: 5,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }


  // Function to add expense to Firestore
  void _addExpenseToFirestore(BuildContext context) {
    // Get data from controllers
    DateTime date = DateTime.parse(_dateController.text);
    String name = _nameController.text;
    double price = double.tryParse(_priceController.text) ?? 0.0;

    // Create an Expense object
    Expense expense = Expense(
      expenseID: 0, // You might want to assign an actual ID
      expenseDate: date,
      name: name,
      amount: price,
      category: 'Your category', // Provide the category as required
    );

    // Call addToFirestore method
    expense.addToFirestore().then((_) {
      // Close the modal
      Navigator.of(context).pop();
    }).catchError((error) {
      // Handle error
      print('Error adding expense to Firestore: $error');
    });

    // Close the modal
    Navigator.of(context).pop();
  }
}
