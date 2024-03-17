import 'package:flutter/material.dart';
import 'package:est/themes/theme.dart';
import 'package:est/screens/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dashboard',
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<Dashboard> {
  int activeDay = 3;

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CustomTheme.themeData, // Set the custom theme data here
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // Add logout functionality here
                // For example, you can navigate to the login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
        backgroundColor: CustomTheme.backgroundColor,
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    List expenses = [
      {
        "icon": Icons.arrow_back,
        "color": CustomTheme.primaryColor,
        "label": "Income",
        "cost": "\$6593.75"
      },
      {
        "icon": Icons.arrow_forward,
        "color": Colors.red,
        "label": "Expense",
        "cost": "\$2645.50"
      }
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  // Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: List.generate(months.length, (index) {
                  //       return GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             activeDay = index;
                  //           });
                  //         },
                  //         child: Container(
                  //           width: (MediaQuery.of(context).size.width - 40) / 6,
                  //           child: Column(
                  //             children: [
                  //               Text(
                  //                 months[index]['label'],
                  //                 style: TextStyle(fontSize: 10),
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Container(
                  //                 decoration: BoxDecoration(
                  //                     color: activeDay == index
                  //                         ? Colors.pink
                  //                         : Colors.black.withOpacity(0.02),
                  //                     borderRadius: BorderRadius.circular(5),
                  //                     border: Border.all(
                  //                         color: activeDay == index
                  //                             ? Colors.pink
                  //                             : Colors.black.withOpacity(0.1))),
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(
                  //                       left: 12, right: 12, top: 7, bottom: 7),
                  //                   child: Text(
                  //                     months[index]['day'],
                  //                     style: TextStyle(
                  //                         fontSize: 10,
                  //                         fontWeight: FontWeight.w600,
                  //                         color: activeDay == index
                  //                             ? Colors.white
                  //                             : Colors.black),
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     }))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Net balance",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\$2446.90",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                          width: (size.width - 20),
                          height: 150,
                          child: Container()),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
              spacing: 20,
              children: List.generate(expenses.length, (index) {
                return GestureDetector(
                  onTap: () {
                    // if (expenses[index]["label"] == "Income") {
                    //   // Navigate to the IncomeDetailsPage
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => RevenuesScreen(),
                    //     ),
                    //   );
                    // } else {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => ExpensesScreen(),
                    //     ),
                    //   );
                    // }
                  },
                  child: Container(
                    width: (size.width - 60) / 2,
                    height: 170,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.01),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: expenses[index]['color']),
                            child: Center(
                                child: Icon(
                              expenses[index]['icon'],
                              color: Colors.white,
                            )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                expenses[index]['label'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color(0xff67727d)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                expenses[index]['cost'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }))
        ],
      ),
    );
  }
}
