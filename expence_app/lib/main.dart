import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import 'package:flutter_complete_guide/model/transaction.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';


void main(){
  // WidgetsFlutterBinding.ensureInitialized(); //control orientation
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  //   ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Quicksand',
        // textTheme:ThemeData.light().textTheme.copyWith(
        // titleLarge: TextStyle(fontFamily: 'Open Sans',fontWeight: FontWeight.bold,fontSize: 18)
        // )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   final List<Transaction> _userTransactions=[];
  void _addNewTransaction(String txTitle,double txAmount,DateTime chooosenDate){
    final newTax=Transaction(
      title:txTitle,
      amount: txAmount,
      id:(DateTime.now()).toString(),
      date:chooosenDate,
      );
      setState(() {
        _userTransactions.add(newTax);
      });
  }
  // String titleInput;
  void _startNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx,
       builder: (_){
        return NewTransaction(_addNewTransaction);
        // return GestureDetector(
        //   onTap: (){},
        //   child: NewTransaction(_addNewTransaction),
        //   behavior: HitTestBehavior.opaque,
        //   );
       }
    );
  }
  void _deleteTransectio(String id){
    setState(() {
      _userTransactions.removeWhere((tx)=>tx.id==id);
    });
  }
   bool _showChart=true;
 List<Transaction> get _recentTransactions{

  return _userTransactions.where((tx){
    return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
  }).toList();
 }
  @override
  Widget build(BuildContext context) {
    final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    final PreferredSizeWidget appBar=Platform.isIOS?CupertinoNavigationBar(
      middle:Text('Flutter Expence App'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        GestureDetector(
          child:Icon(CupertinoIcons.add),
          onTap: () => _startNewTransaction(context),
        )
        ],
      ),
    ):AppBar(
        title: Text('Flutter Expence App',style:Theme.of(context).textTheme.titleLarge,),
        actions: <Widget>[
          IconButton(onPressed: (){
            _startNewTransaction(context);
          }, icon: Icon(Icons.add),)
        ],
      );
      final txList=Container(
                height:(MediaQuery.of(context).size.height-
                appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
              child: TransactionList(_userTransactions,_deleteTransectio)
              );
    
    return Platform.isIOS?CupertinoPageScaffold(): Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
      
             if(isLandscape)Row(
                children: [
                  Text('Show Chart'),
                  Switch.adaptive( 
                  //  activeColor: ,//it will look cupertino for ios
                    value:_showChart,
                    onChanged:(val){
                      setState(() {
                        _showChart=val;
                      });
                      
                    },
                      
                    
                    ),
                ],
              ),
              if(!isLandscape) Container(
                height:(MediaQuery.of(context).size.height-
                  appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
                child: Chart(_recentTransactions)
                ),
              if(!isLandscape)txList,
              if(!isLandscape)_showChart?Container(
                height:(MediaQuery.of(context).size.height-
                  appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
                child: Chart(_recentTransactions)
                ):txList
              
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:Platform.isIOS?Text('ios'):FloatingActionButton(
        onPressed: (){
          _startNewTransaction(context);
        },
        child:Icon(Icons.add)
        ),
    );
  }
}
