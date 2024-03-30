class Expense {
  final int expenseID;
  final DateTime expenseDate;
  final String name;
  final double amount;
  final String category;
  final int? treeID; // Nullable
  final int? salaryPaymentID;

  Expense({
    required this.expenseID,
    required this.expenseDate,
    required this.amount,
    required this.category,
    required this.name,
    this.treeID,
    this.salaryPaymentID,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      expenseID: json['expenseID'],
      expenseDate: DateTime.parse(json['expenseDate']),
      name: json['name'],
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
      'name': name,
      'amount': amount,
      'category': category,
      'treeID': treeID,
      'salaryPaymentID': salaryPaymentID,
    };
  }
}