class SalaryPayment {
  final int salaryPaymentID;
  final int employeeID;
  final double amount;
  final DateTime paymentDate;

  SalaryPayment({
    required this.salaryPaymentID,
    required this.employeeID,
    required this.amount,
    required this.paymentDate,
  });

  factory SalaryPayment.fromJson(Map<String, dynamic> json) {
    return SalaryPayment(
      salaryPaymentID: json['salaryPaymentID'],
      employeeID: json['employeeID'],
      amount: json['amount'].toDouble(),
      paymentDate: DateTime.parse(json['paymentDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'salaryPaymentID': salaryPaymentID,
      'employeeID': employeeID,
      'amount': amount,
      'paymentDate': paymentDate.toIso8601String(),
    };
  }
}
