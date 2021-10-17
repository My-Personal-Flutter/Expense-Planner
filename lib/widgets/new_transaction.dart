import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionFunction;

  NewTransaction({this.addTransactionFunction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInputController = TextEditingController();

  final amountInputController = TextEditingController();

  void submitData() {
    final enteredTitle = titleInputController.text;
    final enteredAmount = double.parse(amountInputController.text);

    if (enteredAmount <= 0 || enteredTitle.isEmpty) {
      return;
    }

    widget.addTransactionFunction(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleInputController,
              keyboardType: TextInputType.name,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountInputController,
              keyboardType: TextInputType
                  .number, //For IOS keyboard type use  =>   TextInputType.numberWithOptions(decimal: true)
              onSubmitted: (_) => submitData(),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: submitData,
              child: Text("Add Transaction"),
              style:
                  TextButton.styleFrom(primary: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
