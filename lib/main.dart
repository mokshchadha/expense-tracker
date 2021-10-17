import './constants.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import './widgets/newTransaction.dart';
import './widgets/transactionList.dart';
import 'widgets/chart.dart';

void main() => runApp(MaterialApp(
      title: 'Chun mun expense tracker',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          primaryColor: Colors.deepPurple.shade500,
          fontFamily: 'OpenSans'),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Transaction> _userTransactions = [];

  Future<void> deleteAllTransactions() async {
    var allTransactionsObj =
        await Constants.DB.collection(Constants.TRANSACTIONS).get();
    allTransactionsObj != null
        ? await Future.wait(allTransactionsObj.entries.map((e) {
            return Constants.DB
                .collection(Constants.TRANSACTIONS)
                .doc(e.key)
                .delete();
          }))
        // ignore: unnecessary_statements
        : [];
  }

  Future<void> _deleteTransaction(String id) async {
    print("deleting $id");
    await Constants.DB
        .collection(Constants.TRANSACTIONS)
        .doc(id.replaceAll('/transactions/', ''))
        .delete();
    fetchExistingTransactionFromDB();
  }

  Future<void> fetchExistingTransactionFromDB() async {
    var allTransactionsObj =
        await Constants.DB.collection(Constants.TRANSACTIONS).get();

    print("-----------------------------------------------");
    print(allTransactionsObj);

    List<Transaction> allTransactions = allTransactionsObj != null
        ? allTransactionsObj.entries.map((e) {
            print(e.value);
            return Transaction(
              id: e.key,
              amount: e.value['amount'],
              title: e.value['title'],
              date: DateTime.parse(e.value['date']),
            );
          }).toList()
        : [];

    List<Transaction> currentMonthTransactions = allTransactions.where((e) {
      return e.date.month == DateTime.now().month;
    }).toList();

    setState(() {
      _userTransactions = currentMonthTransactions;
    });
  }

  @override
  void initState() {
    print("init stateu called");
    fetchExistingTransactionFromDB();
    super.initState();
  }

  Future<void> _addNewTransaction(
      String txTitle, double txAmount, DateTime date) async {
    final id = Constants.DB.collection(Constants.TRANSACTIONS).doc().id;
    final newTx =
        Transaction(id: id, title: txTitle, amount: txAmount, date: date);
    await Constants.DB.collection(Constants.TRANSACTIONS).doc(id).set({
      'title': newTx.title,
      'amount': newTx.amount,
      'date': newTx.date.toIso8601String()
    });
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _showNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((txn) {
      return txn.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chun Mun Expense Tracker',
      home: Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          title: Text('Chun Mun Expense Tracker'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _showNewTransaction(context),
            )
          ],
          backgroundColor: Colors.deepPurple.shade500,
        ),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Chart(_recentTransactions),
              TransactionList(_userTransactions, _deleteTransaction)
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple.shade500,
          hoverColor: Colors.blueAccent,
          child: Icon(Icons.add),
          onPressed: () => _showNewTransaction(context),
        ),
      ),
    );
  }
}
