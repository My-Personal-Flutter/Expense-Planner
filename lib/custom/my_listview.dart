import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class MyListView extends StatefulWidget {
  const MyListView({Key key, this.transactions, this.deleteTx})
      : super(key: key);

  final List<Transaction> transactions;
  final Function deleteTx;

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.custom(
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return TransactionItem(
            key: ValueKey(widget.transactions[index].id),
            transaction: widget.transactions[index],
            deleteTx: widget.deleteTx,
          );
        },
        childCount: widget.transactions.length,
        findChildIndexCallback: (Key key) {
          final ValueKey<String> valueKey = key as ValueKey<String>;
          final String data = valueKey.value;
          return widget.transactions
              .indexWhere((element) => data == element.id);
        },
      ),
    );
  }
}
