import 'dart:io';
import './models/Transaction.dart';
import './widget/Chart.dart';
import 'package:flutter/material.dart';
import './widget/New_Transaction.dart';
import './widget/Transaction_Lists.dart';

void main() {
//if you don't use landscape mode in your app unComment this line of Code

  /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,

  ]);*/


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amberAccent,
        fontFamily: 'Quicksand',

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
   /* Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),*/
  ];
  bool _showChart = false;
  List<Transaction> get _recentTranscations
  {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract( Duration(days: 7),
      ),
      );
    }).toList();
   }

  void _addNewTransaction(String txTitle, double txAmount,var chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
void _deleteTransaction(String id)
{
  setState(() {
    _userTransactions.removeWhere((tx) => tx.id == id);
  });
}
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
   final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text('Personal Expenses',
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,

        ),),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

   final txListWidget = Container(
     height: (mediaQuery.size.height
         - mediaQuery.padding.top) * 0.7,
     child: TransactionList(_userTransactions, _deleteTransaction),);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           if(isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Show Chart'),
                Switch.adaptive(value: _showChart, onChanged: (val)
                {
                  setState(() {
                      _showChart = val;
                  });
                },),
              ],),

          if(!isLandscape ) Container(
     height: (mediaQuery.size.height
         - appBar.preferredSize.height
         - mediaQuery.padding.top) * 0.3,
     child: Chart(_userTransactions),),

            if(!isLandscape) txListWidget,

          if(isLandscape)
              _showChart ? Container(
             height: (mediaQuery.size.height
                 - appBar.preferredSize.height
             - mediaQuery.padding.top) * 0.5,
             child: Chart(_userTransactions),)
          : txListWidget,
          ],
        ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         floatingActionButton: Platform.isIOS ? Container()
          : FloatingActionButton(
            child: const Icon(Icons.add),
             onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
