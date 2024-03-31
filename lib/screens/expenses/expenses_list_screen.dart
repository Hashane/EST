import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:est/widgets/common_screen.dart';
import 'package:est/themes/theme.dart';
import 'package:est/screens/expenses/expenses_add_modal.dart';
import '../../json/daily_json.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:est/models/expense_model.dart';
import 'package:est/Helper.dart';

class ExpensesListScreen extends StatefulWidget {
  @override
  _ExpensesListScreenState createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends State<ExpensesListScreen> {
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
    return CommonScreen(
      title: 'Tools',
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
            calendarStyle: CalendarStyle(
              // Customize colors here
              outsideDaysVisible: true,
              rangeHighlightColor: Colors
                  .green, // Change the color of the range selection highlight
              todayDecoration: BoxDecoration(
                color: CustomTheme
                    .primaryDarkColor, // Change the color of the today cell decoration
                shape: BoxShape.circle,
              ),
              rangeStartDecoration: BoxDecoration(
                color: Colors
                    .orange, // Change the color of the selected cell decoration
                shape: BoxShape.circle,
              ),
              rangeEndDecoration: BoxDecoration(
                color: Colors
                    .orange, // Change the color of the selected cell decoration
                shape: BoxShape.circle,
              ),
              // Add more color customizations as needed
            ),
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
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
              stream: Helper.getExpenses('treeExpenses',startDate: _rangeStart?.toIso8601String(),endDate: _rangeEnd?.toIso8601String()),
              builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.data == null) {
                  return const SizedBox();
                }

                if (snapshot.data!.docs.isEmpty) {
                  return SizedBox(
                    child: Center(
                        child: Text(
                            "No Expenses")),
                  );
                }

                if (snapshot.hasData) {
                  List<Expense> expenses = [];

                  for (var doc in snapshot.data!.docs) {
                    final expense= Expense.fromJson(
                        doc.data() as Map<String, dynamic>);

                    expenses.add(expense);
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          final item = expenses[index];
                          return buildItem(item);
                        },
                      );
                }

                return const SizedBox();
              }),
            )
          ),
        ],
      ),
      onFABPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ExpensesAddModal();
          },
        );
      },
    );
  }

  Widget buildItem(Expense item) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          item.expenseDate.toString(),
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
                    item.amount.toString(),
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
          padding: const EdgeInsets.only(top: 8),
          child: Divider(
            color: Colors.grey,
            thickness: 0.8,
          ),
        )
      ],
    );
  }
}
