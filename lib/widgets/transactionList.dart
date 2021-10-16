import 'package:expensetracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Text("Dear Chun mun, Click + to add your transactions",
                style: TextStyle(color: Colors.white)))
        : Container(
            height: (MediaQuery.of(context).size.height * .6),
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                    color: Colors.grey.shade700,
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.deepPurple,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: FittedBox(
                                  child: Text(
                                "₹${transactions[index].amount.toStringAsFixed(2)}",
                                style: (TextStyle(
                                    fontSize: 15, color: Colors.white)),
                              )))),
                      title: Text(transactions[index].title,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          DateFormat('E dd/MMM/yyyy hh:mm a')
                              .format(transactions[index].date),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ));
              },
              itemCount: transactions.length,
            ));
  }
}
