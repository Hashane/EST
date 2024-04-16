import 'package:cloud_firestore/cloud_firestore.dart';

class Helper {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getExpenses(
      String type, {
        String? startDate,
        String? endDate,
      }) {
    CollectionReference<Map<String, dynamic>> expensesCollection =
    FirebaseFirestore.instance.collection(type);

    // Convert string dates back to DateTime objects
    DateTime? startDateTime = startDate != null ? DateTime.parse(startDate) : null;
    DateTime? endDateTime = endDate != null ? DateTime.parse(endDate) : null;

    // Constructing the query
    Query<Map<String, dynamic>> query = expensesCollection;

    // Filter by start date if provided
    if (startDate != null) {
      query = query.where('expenseDate', isGreaterThanOrEqualTo: startDate);
    }

    // Filter by end date if provided
    if (endDate != null) {
      query = query.where('expenseDate', isLessThanOrEqualTo: endDate);
    }

    // Return the stream of query snapshots
    return query.snapshots();
  }

  static Future<void> addToFirestoreAndUpdateTotal(String collectionName, Map<String, dynamic> expenseData) async {
    try {
      // Get Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add to Firestore
      DocumentReference docRef = await firestore.collection(collectionName).add(expenseData);

      // Update the total expense
      await updateTotalExpense(collectionName,expenseData);

      print('Expense added to Firestore successfully with ID: ${docRef.id}');
    } catch (e) {
      print('Error adding expense to Firestore: $e');
      throw e; // Rethrow the error to be handled by the caller
    }
  }

  /**
   * This method is used to keep track of total
   * of each expense category
   */
  static Future<void> updateTotalExpense(String collectionName, Map<String, dynamic> expenseData) async {
    try {

      double newExpenseAmount = double.tryParse(expenseData['amount'].toString()) ?? 0.0;

      String dateString = expenseData['expenseDate'];
      DateTime expenseDate = DateTime.parse(dateString);

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference expenseTotalRef = firestore.collection('totalExpenses');

      final year = expenseDate.year;
      final month = expenseDate.month;

      DocumentReference yearlyTotalRef = expenseTotalRef.doc(collectionName).collection(year.toString()).doc('yearly');
      DocumentReference monthlyTotalRef = expenseTotalRef.doc(collectionName).collection(year.toString()).doc('monthly_$month');

      // Calculate week number
      final firstJan = DateTime(expenseDate.year, 1, 1);
      final weekNumber = Helper().weeksBetween(firstJan, expenseDate);

      // Construct weekly total reference using the week number
      DocumentReference weeklyTotalRef = expenseTotalRef.doc(collectionName).collection(year.toString()).doc('weekly_${weekNumber.toString()}');

      // Get current total expense
      DocumentSnapshot totalSnapshot = await yearlyTotalRef.get();
      double currentTotal = totalSnapshot.exists ?
      double.tryParse((totalSnapshot.data() as Map<String, dynamic>)['total'].toString()) ?? 0.0 :
      0.0;

      // Update total
      double updatedTotal = currentTotal + newExpenseAmount;

      // Save updated total for yearly
      await yearlyTotalRef.set({'total': updatedTotal});

      // Save updated total for monthly
      DocumentSnapshot monthlySnapshot = await monthlyTotalRef.get();
      double currentMonthlyTotal = monthlySnapshot.exists ?
      double.tryParse((monthlySnapshot.data() as Map<String, dynamic>)['total'].toString()) ?? 0.0 :
      0.0;
      double updatedMonthlyTotal = currentMonthlyTotal + newExpenseAmount;
      await monthlyTotalRef.set({'total': updatedMonthlyTotal});

      // Save updated total for weekly
      DocumentSnapshot weeklySnapshot = await weeklyTotalRef.get();
      double currentWeeklyTotal = weeklySnapshot.exists ?
      double.tryParse((weeklySnapshot.data() as Map<String, dynamic>)['total'].toString()) ?? 0.0 :
      0.0;
      double updatedWeeklyTotal = currentWeeklyTotal + newExpenseAmount;
      Map<String, dynamic> weeklyData = {'total': updatedWeeklyTotal};
      await weeklyTotalRef.set(weeklyData);

      print('Total expense updated successfully!');
    } catch (e) {
      print('Error updating total expense: $e');
      throw e;
    }
  }

  int weeksBetween(DateTime from, DateTime to) {
    from = DateTime.utc(from.year, from.month, from.day);
    to = DateTime.utc(to.year, to.month, to.day);
    return (to.difference(from).inDays / 7).ceil();
  }
}
