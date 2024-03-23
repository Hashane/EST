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
        // Handle FAB press here
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
