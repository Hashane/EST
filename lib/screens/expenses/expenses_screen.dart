import 'package:flutter/material.dart';
import 'package:est/widgets/custom_app_bar.dart';
import 'package:est/themes/theme.dart';
import 'package:est/widgets/common_screen.dart';
import 'package:est/screens/expenses/expenses_bar_chart_screen.dart';

class ExpensesScreen extends StatefulWidget {
  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  String _selectedPeriod = 'Monthly'; // Default selected period

  final List<double> expenses = [100000, 70000, 30000, 80000];
  final List<String> categories = ['Trees', 'Utilities', 'Tools', 'Others'];

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;
    return CommonScreen(
      title: 'Expenses',
      body: Column(
        children: [
          Center(child:Text(
            'Categories',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25),
          ),
          ),
          SizedBox(height: 20),
          // Period selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPeriodTab('Monthly'),
              _buildPeriodTab('Daily'),
              _buildPeriodTab('Weekly'),
              _buildPeriodTab('Yearly'),
            ],
          ),
          SizedBox(height: 20),
          // Expenses by categories
          Container(
            height: screenSize.height * 0.5 + 60,
            child:HorizontalBarChart(expenses: expenses, categories: categories),
          ),
          SizedBox(height: 20),
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
          color: _selectedPeriod == period ? CustomTheme.primaryDarkColor : Colors.transparent,
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

