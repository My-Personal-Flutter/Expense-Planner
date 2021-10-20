import 'package:expense_planner/custom/adaptive_button.dart';
import 'package:expense_planner/custom/adaptive_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class NewTransaction extends StatefulWidget {
  final Function addTransactionFunction;

  NewTransaction({this.addTransactionFunction}) {
    print("Constructor NewTransaction");
  }

  @override
  State<NewTransaction> createState() {
    print(" createState");

    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInputController = TextEditingController();

  final _amountInputController = TextEditingController();

  DateTime _selectedDate;

  _NewTransactionState() {
    print("Constructor _NewTransactionState");
  }

  @override
  void initState() {
    super.initState();
    print("_NewTransactionState initState");
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("_NewTransactionState didUpdateWidget");
  }

  @override
  void dispose() {
    super.dispose();
    print("_NewTransactionState dispose");
  }

  void _submitData() {
    if (_amountInputController.text.isEmpty) return;

    final enteredTitle = _titleInputController.text;
    final enteredAmount = double.parse(_amountInputController.text);

    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }

    widget.addTransactionFunction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value == null) return;
        setState(
          () {
            _selectedDate = value;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    // final _islandscape = mediaQuery.orientation == Orientation.landscape;

    return SafeArea(
      child: SingleChildScrollView(
        child: Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Platform.isIOS
                    ? CupertinoTextField(
                        placeholder: "Title",
                        controller: _titleInputController,
                        keyboardType: TextInputType.name,
                        onSubmitted: (_) => _submitData(),
                      )
                    : TextField(
                        decoration: InputDecoration(labelText: "Title"),
                        controller: _titleInputController,
                        keyboardType: TextInputType.name,
                        onSubmitted: (_) => _submitData(),
                      ),
                Platform.isIOS
                    ? const SizedBox(
                        height: 20,
                      )
                    : Container(),
                Platform.isIOS
                    ? CupertinoTextField(
                        placeholder: "Amount",
                        controller: _amountInputController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => _submitData(),
                      )
                    : TextField(
                        decoration: InputDecoration(labelText: "Amount"),
                        controller: _amountInputController,
                        keyboardType: TextInputType
                            .number, //For IOS keyboard type use  =>   TextInputType.numberWithOptions(decimal: true)
                        onSubmitted: (_) => _submitData(),
                      ),
                Container(
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                        child: Platform.isIOS
                            ? CupertinoTextField.borderless(
                                enabled: false,
                                placeholder: _selectedDate == null
                                    ? "No Date Choosen"
                                    : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}",
                                placeholderStyle: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                              )
                            : Text(
                                _selectedDate == null
                                    ? "No Date Choosen"
                                    : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}",
                                style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                              ),
                      ),
                      AdaptiveTextButton(
                        buttonText: "Choose Date",
                        handler: _presentDatePicker,
                      ),
                    ],
                  ),
                ),
                Platform.isIOS
                    ? const SizedBox(
                        height: 20,
                      )
                    : Container(),
                AdaptiveButon(
                  buttonText: "Add Transaction",
                  handler: _submitData,
                ),
                Platform.isIOS
                    ? const SizedBox(
                        height: 20,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
