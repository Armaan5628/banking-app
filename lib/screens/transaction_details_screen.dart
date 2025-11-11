// transaction_details_screen.dart
// Displays all transactions for a selected account, sorted from newest to oldest.

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final String accountType;
  final List<TransactionModel> transactions;

  const TransactionDetailsScreen({
    super.key,
    required this.accountType,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    // Copy list so we don't modify original
    final sortedTransactions = List<TransactionModel>.from(transactions);

    // Sort by date (newest first)
    sortedTransactions.sort((a, b) {
      final dateA = DateTime.parse(a.date);
      final dateB = DateTime.parse(b.date);
      return dateB.compareTo(dateA);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$accountType Transactions',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: const Color(0xFF1A237E),
        centerTitle: true,
        elevation: 6,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: sortedTransactions.isEmpty
          ? const Center(child: Text('No transactions found'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sortedTransactions.length,
              itemBuilder: (context, index) {
                final tx = sortedTransactions[index];
                final formattedDate =
                    DateFormat('MMM dd, yyyy').format(DateTime.parse(tx.date));

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: tx.amount < 0
                          ? Colors.red.shade100
                          : Colors.green.shade100,
                      child: Icon(
                        tx.amount < 0
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: tx.amount < 0 ? Colors.red : Colors.green,
                      ),
                    ),
                    title: Text(
                      tx.description,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Date: $formattedDate'),
                    trailing: Text(
                      '\$${tx.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: tx.amount < 0 ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
