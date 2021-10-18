import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        errorColor: Colors.red[700],
        secondaryHeaderColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: Colors.black,
          onSecondary: Colors.white,
        ),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              subtitle2: TextStyle(
                color: Colors.grey,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "t1",
      title: "New Shoes",
      amount: 30.12,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Glasses",
      amount: 10.12,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t3",
      title: "Shirts",
      amount: 12.12,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t1",
      title: "New Shoes",
      amount: 30.12,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Glasses",
      amount: 10.12,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t3",
      title: "Shirts",
      amount: 12.12,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t1",
      title: "New Shoes",
      amount: 30.12,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Glasses",
      amount: 10.12,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t3",
      title: "Shirts",
      amount: 12.12,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: selectedDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransactionModel(BuildContext buildContext) {
    showModalBottomSheet(
      enableDrag: true,
      context: buildContext,
      builder: (_) {
        return NewTransaction(
          addTransactionFunction: _addNewTransaction,
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _islandscape = mediaQuery.orientation == Orientation.landscape;
    final _appBar = AppBar(
      title: Text('Personal Expenses'),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransactionModel(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    final _txListWidget = Container(
      height: (mediaQuery.size.height -
              _appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        transactions: _userTransactions,
        deleteTx: _deleteTransaction,
      ),
    );
    return Scaffold(
        appBar: _appBar,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_islandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Show Chart",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      },
                      activeColor: Theme.of(context).secondaryHeaderColor,
                    ),
                  ],
                ),
              if (!_islandscape)
                Container(
                  height: (mediaQuery.size.height -
                          _appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(
                    recentTransactions: _recentTransactions,
                  ),
                ),
              if (!_islandscape) _txListWidget,
              if (_islandscape)
                _showChart
                    ? Container(
                        height: (mediaQuery.size.height -
                                _appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.76,
                        child: Chart(
                          recentTransactions: _recentTransactions,
                        ),
                      )
                    : _txListWidget
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransactionModel(context),
          child: Icon(
            Icons.add,
          ),
        ));
  }
}
