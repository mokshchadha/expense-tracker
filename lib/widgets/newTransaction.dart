import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTxn;
  NewTransaction(this.addNewTxn);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInputController = TextEditingController();

  final amountInputController = TextEditingController();

  void submitData(context) {
    var enteredAmount = amountInputController.text.isEmpty
        ? 0.0
        : double.parse(amountInputController.text);
    var enteredTitle = titleInputController.text;
    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    widget.addNewTxn(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade600),
        color: Colors.grey.shade800,
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: titleInputController,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              labelText: 'What did you buy?',
              labelStyle: TextStyle(color: Colors.pinkAccent.shade100),
            ),
            style: TextStyle(color: Colors.pinkAccent.shade100),
            onSubmitted: (_) => submitData(context),
          ),
          TextField(
            controller: amountInputController,
            cursorColor: Colors.blue,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'How much did you pay for it?',
              labelStyle: TextStyle(color: Colors.purpleAccent.shade100),
            ),
            style: TextStyle(color: Colors.purpleAccent.shade100),
            onSubmitted: (_) => submitData(context),
          ),
          TextButton(
              onPressed: () => submitData(context),
              child: Text("Add Transaction",
                  style: TextStyle(color: Colors.blueAccent.shade100)))
        ],
      ),
    ));
  }
}
