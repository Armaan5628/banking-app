// account_list_screen.dart
// Displays all user accounts in elegant card layout with matching header & buttons.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import 'transaction_details_screen.dart';

class AccountListScreen extends StatefulWidget {
  const AccountListScreen({super.key});

  @override
  State<AccountListScreen> createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  List<Account> accounts = [];
  Map<String, List<TransactionModel>> transactions = {};

  // Load data from JSON files
  Future<void> loadData() async {
    final accountJson = await rootBundle.loadString('lib/data/accounts.json');
    final accountData = jsonDecode(accountJson);
    accounts = (accountData['accounts'] as List)
        .map((a) => Account.fromJson(a))
        .toList();

    final transactionJson =
        await rootBundle.loadString('lib/data/transactions.json');
    final transactionData = jsonDecode(transactionJson)['transactions'];

    transactionData.forEach((key, value) {
      transactions[key] =
          (value as List).map((t) => TransactionModel.fromJson(t)).toList();
    });

    setState(() {});
  }

  // Mask account numbers dynamically with asterisks
  String maskAccountNumber(String accNumber) {
    if (accNumber.length <= 4) return accNumber;
    String hidden = '*' * (accNumber.length - 4);
    String last4 = accNumber.substring(accNumber.length - 4);
    return '$hidden $last4';
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🟦 Beautiful AppBar matching button theme
      appBar: AppBar(
        title: const Text(
          'Your Accounts',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A237E), // deep royal blue
        elevation: 6,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // 🧾 Account cards
      body: accounts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final account = accounts[index];
                final maskedNumber = maskAccountNumber(account.accountNumber);

                // Custom icons for each account type
                final icon = account.type.toLowerCase().contains('saving')
                    ? Icons.savings_rounded
                    : Icons.credit_card_rounded;

                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Colors.indigo.shade50, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Leading circle icon
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A237E).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            size: 32,
                            color: const Color(0xFF1A237E),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Account info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${account.type} Account',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF1A237E),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Account Number: $maskedNumber',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontFamily: 'Courier',
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Balance: \$${account.balance.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // View Transactions button
                        Column(
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1A237E),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 3,
                              ),
                              icon: const Icon(Icons.receipt_long, size: 18),
                              label: const Text(
                                'View\nTransactions',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TransactionDetailsScreen(
                                      accountType: account.type,
                                      transactions:
                                          transactions[account.type] ?? [],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
