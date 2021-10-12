import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleInputController = TextEditingController();
  final amountInputController = TextEditingController();
  final Function addTransactionFunction;

  NewTransaction({this.addTransactionFunction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleInputController,
              // onChanged: (e) => {titleInput = e},
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountInputController,
              // onChanged: (e) => {amountInput = e},
            ),
            TextButton(
              onPressed: () => {
                addTransactionFunction(
                  titleInputController.text,
                  double.parse(amountInputController.text),
                )
              },
              child: Text("Add Transaction"),
              style: TextButton.styleFrom(primary: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }
}
