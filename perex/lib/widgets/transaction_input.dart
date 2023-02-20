import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionInput extends StatefulWidget {
  final Function(String, double, DateTime) onSubmit;

  const TransactionInput({required this.onSubmit, super.key});

  @override
  State<StatefulWidget> createState() {
    return _TransactionInputState();
  }
}

class _TransactionInputState extends State<TransactionInput> {
  final TextEditingController _titleEditController = TextEditingController();
  final TextEditingController _amountEditController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitInput() {
    final title = _titleEditController.text;
    final amount = _amountEditController.text;

    if (title.isEmpty || amount.isEmpty) {
      return;
    }

    final parsedAmount = double.parse(amount);

    if (parsedAmount <= 0) {
      return;
    }

    widget.onSubmit(title, parsedAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime.now())
        .then(
      (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selectedDate = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 5,
            left: 5,
            right: 5,
            bottom: MediaQuery.of(context).viewInsets.bottom + 5,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleEditController,
              // onSubmitted: (_) => submitInput(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'),
                  TextButton(
                      onPressed: _showDatepicker, child: const Text('Choose'))
                ],
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountEditController,
              onSubmitted: (_) => _submitInput(),
            ),
            ElevatedButton(onPressed: _submitInput, child: const Text('Add'))
          ]),
        )));
  }
}
