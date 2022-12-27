import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '.././models/transaction.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final inputTitleController = TextEditingController();
  final inputAmountController = TextEditingController();
  DateTime _pickedDateTime = DateTime.now();

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _pickedDateTime = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: inputTitleController,
            // onChanged: (val) => inputTitle = val,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: inputAmountController,
            keyboardType: TextInputType.number,
            // onChanged: (val) => inputAmount = val,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                    child: Text(DateFormat.yMMMd().format(_pickedDateTime))),
                FlatButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose date',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).buttonColor,
              onPressed: () {
                widget.addNewTransaction(
                    inputTitleController.text, inputAmountController.text, _pickedDateTime);
              },
              child: Text(
                'Add Transaction',
              ))
        ],
      ),
    );
  }
}
