import 'dart:io';
import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
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

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Show Chart",
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
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
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.76,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            )
          : txListWidget,
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(
          recentTransactions: _recentTransactions,
        ),
      ),
      txListWidget
    ];
  }

  PreferredSizeWidget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                  ),
                  onTap: () => _startAddNewTransactionModel(context),
                )
              ],
            ),
          )
        : AppBar(
            title: const Text('Personal Expenses'),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransactionModel(context),
                icon: const Icon(Icons.add),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _islandscape = _mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget _appBar = _buildAppBar();
    final _txListWidget = Container(
      height: (_mediaQuery.size.height -
              _appBar.preferredSize.height -
              _mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        transactions: _userTransactions,
        deleteTx: _deleteTransaction,
      ),
    );
    final _body = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_islandscape)
              ..._buildLandscapeContent(
                _mediaQuery,
                _appBar,
                _txListWidget,
              ),
            if (!_islandscape)
              ..._buildPortraitContent(
                _mediaQuery,
                _appBar,
                _txListWidget,
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _body,
            navigationBar: _appBar,
          )
        : Scaffold(
            appBar: _appBar,
            body: _body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransactionModel(context),
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
          );
  }
}
