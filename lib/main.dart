import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            shadowColor: Colors.red,
            color: Colors.green,
            elevation: 4,
            child: Container(
              width: double.infinity,
              child: Text("Chart"),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              shadowColor: Colors.blue,
              color: Colors.orange,
              elevation: 4,
              child: Text("Playground"),
            ),
          ),
          Card(
            shadowColor: Colors.purple,
            color: Colors.pink,
            elevation: 4,
            child: Text(
              "New Playground",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
