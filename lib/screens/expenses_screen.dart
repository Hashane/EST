import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:est/json/daily_json.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:est/models/expense_model.dart';
import 'package:est/services/firestore_service.dart';
import 'package:est/services/common_service.dart';

class ExpensesScreen extends StatefulWidget {
  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay; // Initialize with a default value
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  void _onRangeSelected(
      DateTime? startDate, DateTime? endDate, DateTime? focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = _focusedDay;
      _rangeStart = startDate;
      _rangeEnd = endDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: RangeSelectionMode.toggledOn,
            onRangeSelected: _onRangeSelected,
            calendarStyle: const CalendarStyle(outsideDaysVisible: true),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(height: 20,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Adjust the padding as needed
              child: ListView.builder(
                itemCount: daily.length,
                itemBuilder: (context, index) {
                  final item = daily[index];
                  return buildExpenseItem(item);
                },
              ),
            ),
          ),
          // Your other content here
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddExpenseDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildExpenseItem(Map<String, dynamic> item) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: (size.width - 40) * 0.7,
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Image.asset(
                        item['icon'],
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: (size.width - 90) * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          item['date'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: (size.width - 40) * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    item['price'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 65, top: 8),
          child: Divider(
            thickness: 0.8,
          ),
        )
      ],
    );
  }
}


class AddExpenseDialog extends StatefulWidget {
  @override
  _AddExpenseDialogState createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDateField(context),
          SizedBox(height: 10),
          _buildItemNameField(),
          SizedBox(height: 10),
          _buildCategoryDropdown(),
          SizedBox(height: 10),
          _buildAmountField(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle the "Add Expense" button action here
            // You can access the entered data using _selectedDate, _itemNameController.text, _amountController.text, and _selectedCategory
            final expense = Expense(
              expenseID: CommonService().generateUniqueId(), // Generate a unique ID for the expense
              name : _itemNameController.text,
            expenseDate: _selectedDate,
              amount: double.parse(_amountController.text),
              category: _selectedCategory,
            );

            // Add the expense to Firestore
            FirestoreService().addExpense(expense);

            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Add Expense'),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Category:',
        border: OutlineInputBorder(),
      ),
      value: _selectedCategory.isNotEmpty ? _selectedCategory : null, // Set an initial value
      onChanged: (newValue) {
        setState(() {
          _selectedCategory = newValue!;
        });
      },
      items: <String>[
        'Groceries',
        'Rent',
        'Utilities',
        'Transportation',
        'Entertainment',
        'Healthcare',
        'Education',
        'Others',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        ).then((pickedDate) {
          if (pickedDate != null && pickedDate != _selectedDate) {
            setState(() {
              _selectedDate = pickedDate;
            });
          }
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Date:'),
          Text(
            '${_selectedDate.toLocal()}'.split(' ')[0],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.calendar_today),
        ],
      ),
    );
  }

  Widget _buildItemNameField() {
    return TextField(
      controller: _itemNameController,
      decoration: InputDecoration(
        labelText: 'Expense Name:',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildAmountField() {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Amount (Rs.):',
        border: OutlineInputBorder(),
      ),
    );
  }
}
