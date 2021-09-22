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
                    elevation: 3,
                    color: Colors.grey.shade800,
                    shadowColor: Colors.grey.shade200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.purpleAccent, width: 2)),
                            child: Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: FittedBox(
                                  child: Text(
                                      "₹${transactions[index].amount.toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color:
                                              Colors.purpleAccent.shade200))),
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(transactions[index].title,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue.shade200,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                DateFormat('E dd/MMM/yyyy hh:mm a')
                                    .format(transactions[index].date),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    ));
              },
              itemCount: transactions.length,
            ));
  }
}
