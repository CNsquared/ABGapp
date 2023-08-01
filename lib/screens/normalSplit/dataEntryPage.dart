import 'dart:developer';

import 'package:abg_app/models/transactionRecord.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/dataEntryCustomWidgets.dart';

///Takes in user input of what the tax, tip and number of people is
///
//TODO make the keyboard go down when click out of text filling items

class DataEntryPage extends StatefulWidget {
  final PageController pageController;

  DataEntryPage({required this.pageController});
  @override
  State<DataEntryPage> createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  final Map<String, TextEditingController> textControllers = {
    "numPeople": TextEditingController(),
    "tax": TextEditingController(),
    "tip": TextEditingController()
  };

  double? tip;
  double? tax;
  int? numPeople;

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    textControllers["numPeople"]!.addListener(() {
      if (textControllers["numPeople"]!.text != "") {
        numPeople = int.parse(textControllers["numPeople"]!.text);
        log("numPeople set as $numPeople");
      }
    });
    textControllers["tax"]!.addListener(() {
      if (textControllers["tax"]!.text != "") {
        tax = double.parse(textControllers["tax"]!.text);
        log("tax set as $tax");
      }
    });
    textControllers["tip"]!.addListener(() {
      if (textControllers["tip"]!.text != "") {
        tip = double.parse(textControllers["tip"]!.text);
        log("tip set as $tip");
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the listeners.

    textControllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  bool dataFilled() {
    return (numPeople != null && tax != null && tip != null);
  }

  @override
  Widget build(BuildContext context) {
    var card = Card(
      child: Column(
        children: <Widget>[
        EntryForm(
          controller: textControllers["numPeople"]!,
          prompt: "Number of People",
          icon: Icon(Icons.people),
          filter: "integer",
        ),
        EntryForm(
          controller: textControllers["tip"]!,
          prompt: "Tip",
          icon: Icon(Icons.attach_money_rounded),
          filter: "money",
        ),
        EntryForm(
          controller: textControllers["tax"]!,
          prompt: "Tax",
          icon: Icon(Icons.attach_money_rounded),
          filter: "money",
        ),
        submitButton(context),
        clearButton(),
      ]),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        //*DESIGN TEAM
        padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
        child: Column(
          children: [
            //*Design TEAM
            Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Add Values",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                )),
            //*DESIGN TEAM
            SizedBox(height: 20),
            Expanded(
              child: card,
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton clearButton() {
    return ElevatedButton(
        onPressed: () {
          log("Clear data entry");
          FocusScope.of(context).unfocus();
          textControllers.forEach((key, value) {
            value.clear();
          });
          tip = null;
          tax = null;
          numPeople = null;
        },
        child: Text("Clear", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)));
  }

  ///Submit button for the [DataEntryPage] that is passed a [PageController] and navigates to page 1
  ElevatedButton submitButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          var logState = Provider.of<TransactionRecord>(context, listen: false);
          FocusScope.of(context).unfocus();
          await logState.intializeRecord();

          if (dataFilled()) {
            logState.addTransaction(tax: tax, tip: tip, numPeople: numPeople, splittingMethod: "equalTaxTip");
            widget.pageController.animateToPage(1,
                duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
          }
        },
        child: Text("Submit", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)));
  }
}
