import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                "\$${transaction.amount.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: Theme.of(context).textTheme.subtitle2,
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () => deleteTx(transaction.id),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: Text(
                  "Delete",
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () => deleteTx(transaction.id),
              ),
      ),
    );
  }
}


// Card(
//                   margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
//                   elevation: 1,
//                   child: Row(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.symmetric(
//                           vertical: 10,
//                           horizontal: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Theme.of(context).primaryColor,
//                             width: 1.5,
//                           ),
//                         ),
//                         padding: EdgeInsets.all(4),
//                         child: Text(
//                           "\$${transactions[index].amount.toStringAsFixed(2)}",
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             transactions[index].title,
//                             style: Theme.of(context).textTheme.headline6,
//                           ),
//                           Text(
//                             DateFormat.yMMMd().format(transactions[index].date),
//                             style: TextStyle(
//                               color: Colors.grey,
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 );
//               },