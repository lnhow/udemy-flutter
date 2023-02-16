import 'package:flutter/material.dart';
import 'package:perex/widgets/transaction.dart';

import 'widgets/chart.dart';
import 'model/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'perex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static final List<Transaction> transactions = [
    Transaction(id: '1', title: 'Banh mi', amount: 50, date: DateTime.now()),
    Transaction(id: '2', title: 'Banh bao', amount: 100, date: DateTime.now()),
  ];
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('perex'),
      ),
      body: Column(
        children: <Widget>[
          const Chart(),
          Column(children: transactions.map((tx) {
            return TransactionWidget(tx: tx);
          }).toList(),)
        ],
      ),
    );
  }
}
