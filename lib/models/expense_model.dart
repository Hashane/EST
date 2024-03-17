class Expenses {
  final int expenseID;
  final DateTime expenseDate;
  final double amount;
  final String category;
  final int? treeID; // Nullable
  final int? salaryPaymentID;

  Expenses({
    required this.expenseID,
    required this.expenseDate,
    required this.amount,
    required this.category,
    this.treeID,
    this.salaryPaymentID,
  });

  factory Expenses.fromJson(Map<String, dynamic> json) {
    return Expenses(
      expenseID: json['expenseID'],
      expenseDate: DateTime.parse(json['expenseDate']),
      amount: json['amount'].toDouble(),
      category: json['category'],
      treeID: json['treeID'],
      salaryPaymentID: json['salaryPaymentID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expenseID': expenseID,
      'expenseDate': expenseDate.toIso8601String(),
      'amount': amount,
      'category': category,
      'treeID': treeID,
      'salaryPaymentID': salaryPaymentID,
    };
  }
}