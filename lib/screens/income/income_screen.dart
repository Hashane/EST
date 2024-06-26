import 'package:flutter/material.dart';
import 'package:est/widgets/custom_app_bar.dart';
import 'package:est/themes/theme.dart';
import 'package:est/widgets/common_screen.dart';

class IncomeScreen extends StatefulWidget {
  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  String _selectedPeriod = 'Monthly'; // Default selected period
  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      title: 'Income',
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
          // Income by categories
          Container(
            height: 200,
            child: Placeholder(), // Placeholder for horizontal bars
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

