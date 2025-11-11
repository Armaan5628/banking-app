class Account {
  final String type;
  final String accountNumber;
  final double balance;

  Account({
    required this.type,
    required this.accountNumber,
    required this.balance,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      type: json['type'],
      accountNumber: json['account_number'],
      balance: json['balance'].toDouble(),
    );
  }
}
