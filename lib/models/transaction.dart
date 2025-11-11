class TransactionModel {
  final String date;
  final String description;
  final double amount;

  TransactionModel({
    required this.date,
    required this.description,
    required this.amount,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      date: json['date'],
      description: json['description'],
      amount: json['amount'].toDouble(),
    );
  }
}
