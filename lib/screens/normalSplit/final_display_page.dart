

import 'dart:developer';

import 'package:abg_app/common/expenses.dart';
import 'package:abg_app/common/payment_calculator.dart';
import 'package:abg_app/main.dart';
import 'package:abg_app/models/transaction_record.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

///Displays the calculated amount due
class FinalDisplayPage extends StatelessWidget {
  final PageController pageController;
  static const String routeName = "/finalDisplay";

  FinalDisplayPage({required this.pageController});

  @override
  // TODO needs full redesign
  Widget build(BuildContext context) {
    log("Final Display Page");
    return Column(children: <Widget>[
      SizedBox(height: 50),
      Container(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          height: 75,
          width: 200,
          child: Card(
            child:
                Center(child: Text("Log It", style: TextStyle(fontSize: 32))),
          ),
        ),
      ),
      SizedBox(
        height: 300,
        width: 350,
        child: Card(
          elevation: 50,
          child: Column(children: <Widget>[
            DisplayInputData(),
            SizedBox(height: 100),
          ]),
        ),
      ),
      SizedBox(
          height: 100,
          width: 350,
          child: Card(
            child: DisplayAmountDue(),
          )),
      Row(children: <Widget>[
        ElevatedButton(
          onPressed: () {
            context.go(HomePage.routeName);
          },
          child: Icon(Icons.home),
        ),
        ElevatedButton(
          onPressed: () {
            pageController.animateToPage(0,
                duration: Duration(milliseconds: 250), curve: Curves.easeIn);
          },
          child: Icon(Icons.arrow_back),
        ),
      ])
    ]);
  }
}

///Displays the users inputted data
class DisplayInputData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var logState = Provider.of<TransactionRecord>(context, listen: true);
    log("logState: ${logState.expenses.toString()}");
    var latestTransaction = logState.expenses.last;

    return Column(children: <Widget>[
      Text("People: ${latestTransaction.numPeople}"),
      Text("Tip ${latestTransaction.tip}"),
      Text("Tax: ${latestTransaction.tax}")
    ]);
  }
}

///Displays the amount each person should pay calulcated by [PaymentCalculator]
class DisplayAmountDue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var logState = Provider.of<TransactionRecord>(context, listen: true);
    Expense latestTransaction = logState.expenses.last;

    return ListView.builder(
        itemCount: latestTransaction.people.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Amount Due: ${latestTransaction.people[index].cost}"),
          );
        },);
  }
}
