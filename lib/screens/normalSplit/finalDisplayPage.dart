import 'package:abg_app/common/paymentCalculator.dart';
import 'package:abg_app/models/transactionRecord.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

///Displays the calculated amount due
class FinalDisplayPage extends StatelessWidget {
  final PageController pageController;

  FinalDisplayPage({required this.pageController});

  @override
  // TODO needs full redesign
  Widget build(BuildContext context) {
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
            context.go("/home");
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
    var logState = Provider.of<TransactionRecord>(context, listen: false);
    var latestTransaction = logState.expenses[logState.expenses.length - 1];

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
    var logState = Provider.of<TransactionRecord>(context, listen: false);
    var latestTransaction = logState.expenses[logState.expenses.length - 1];

    var paymentCalculator = PaymentCalculator();
    var amountDue = paymentCalculator.splitTax(
            latestTransaction.tax, latestTransaction.numPeople) +
        paymentCalculator.splitTip(
            latestTransaction.tip, latestTransaction.numPeople);
    return Text(
      "Amount Due: ${amountDue.toStringAsFixed(2)}",
    );
  }
}
