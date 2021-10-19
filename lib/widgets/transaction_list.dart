import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList({this.transactions, this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraint) {
                return Column(
                  children: [
                    Text(
                      "No Transactions Added Yet!",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: constraint.maxHeight * 0.1),
                    Container(
                      height: constraint.maxHeight * 0.6,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionItem(
                  transaction: transactions[index],
                  deleteTx: deleteTx,
                );
              }),
    );
  }
}
