import 'package:abg_app/models/normalSplitRecipt.dart';
import 'package:abg_app/paymentCalculator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

///Displays the calculated amount due
class FinalDisplayPage extends StatelessWidget {
  late PageController pageController;
  FinalDisplayPage(PageController controller) {
    pageController = controller;
  }

  @override
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
          child: Icon(Icons.home),
        ),
      ])
    ]);
  }
}

///Displays the users inputted data
class DisplayInputData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<NormalSplitRecipt>(context, listen: false);

    return Column(children: <Widget>[
      Text("People: ${appState.numPeople}"),
      Text("Tip ${appState.tipValue}"),
      Text("Tax: ${appState.taxValue}")
    ]);
  }
}

///Displays the amount each person should pay calulcated by [PaymentCalculator]
class DisplayAmountDue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<NormalSplitRecipt>();
    var paymentCalculator = PaymentCalculator();
    var amountDue =
        paymentCalculator.splitTax(appState.taxValue, appState.numPeople) +
            paymentCalculator.splitTip(appState.tipValue, appState.numPeople);
    return Text(
      "Amount Due: ${amountDue.toStringAsFixed(2)}",
    );
  }
}
