import 'package:expensetracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class TransactionList extends StatefulWidget {
  List<Transaction> transactions;
  var deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
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
                                "₹${widget.transactions[index].amount.toStringAsFixed(2)}",
                                style: (TextStyle(
                                    fontSize: 15, color: Colors.white)),
                              )))),
                      title: Text(widget.transactions[index].title,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          DateFormat('E dd/MMM/yyyy hh:mm a')
                              .format(widget.transactions[index].date),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      trailing: IconButton(
                          onPressed: () {
                            widget.deleteTransaction(
                                widget.transactions[index].id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.pink,
                          ))),
                );
              },
              itemCount: widget.transactions.length,
            ));
  }
}
