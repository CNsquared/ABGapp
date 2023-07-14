
import 'package:abg_app/paymentCalculator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class FinalScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children:<Widget>[ 
        SizedBox(height: 50), 
        Card(
          elevation: 50,
          child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Text("Log It", style: TextStyle(fontSize: 32)),
                SizedBox(height: 30, width: 300),
                DisplayAmountDue(),
                SizedBox(height: 100), 
              ]
          ),
        ),
        SizedBox(height: 40),
      ]
    );

  }

}

class DisplayAmountDue  extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    var appState = context.watch<AbgAppState>();
    var paymentCalculator = PaymentCalculator();
    var amountDue = paymentCalculator.splitTax(appState.taxValue, appState.numPeople) + paymentCalculator.splitTip(appState.tipValue, appState.numPeople);
    return Text(
      "Amount Due: $amountDue",
    );
  }
}