import 'package:flutter/material.dart';
import 'package:est/widgets/custom_app_bar.dart';
import 'package:est/themes/theme.dart';
import 'package:est/widgets/common_screen.dart';

class Employee {
  final String name;
  final String position;
  final double salary;

  Employee({
    required this.name,
    required this.position,
    required this.salary,
  });
}

class EmployeesScreen extends StatefulWidget {
  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  String _selectedPeriod = 'Permanent'; // Default selected
  List<Employee> employees = [
    Employee(name: 'John Doe', position: 'Software Engineer', salary: 5000),
    Employee(name: 'Jane Smith', position: 'UI Designer', salary: 4500),
    Employee(name: 'Michael Johnson', position: 'Project Manager', salary: 6000),
    // Add more employees as needed
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      title: 'Employees',
      body: Column(
        children: [
          Row(
            children: <Widget>[
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Period selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPeriodTab('Permanent'),
              _buildPeriodTab('Casual'),
            ],
          ),
          SizedBox(height: 20),
          // Employee list
          Expanded(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text(
                    '${employee.position} - \$${employee.salary.toStringAsFixed(2)}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.attach_money),
                        onPressed: () {
                          // Handle pay action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          // Handle view details action
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      onFABPressed: () {
        // Show modal when FAB is pressed
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            // Calculate the desired height as a percentage of the screen height
            double screenHeight = MediaQuery.of(context).size.height;
            double desiredHeight = screenHeight * 0.8; // Adjust the percentage as needed

            return CustomBottomSheet(
              height: desiredHeight,
              content: UpdateModal(), // Your modal widget
            );
          },
          isScrollControlled: true, // Enable scroll control
        );
      },
    );
  }

  Widget _buildPeriodTab(String period) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPeriod = period;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: _selectedPeriod == period
              ? CustomTheme.primaryDarkColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          period,
          style: TextStyle(
            color: _selectedPeriod == period ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Your modal widget
class UpdateModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your input',
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Handle update button press
              Navigator.pop(context); // Close the modal
            },
            child: Text('Update'),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

// Custom bottom sheet widget with rounded top corners
class CustomBottomSheet extends StatelessWidget {
  final Widget content;
  final double height;

  const CustomBottomSheet({
    Key? key,
    required this.content,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: content,
    );
  }
}
