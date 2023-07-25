import 'dart:developer';

import 'package:abg_app/models/transactionRecord.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

///Takes in user input of what the tax, tip and number of people is
///
// ! Planning on deprecated the use of OnChanged for the buttons as well as [_Transaction]
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
      numPeople = int.parse(textControllers["numPeople"]!.text);
      log("numPeople set as ${numPeople}");
    });
    textControllers["tax"]!.addListener(() {
      tax = double.parse(textControllers["tax"]!.text);
      log("tax set as ${tax}");
    });
    textControllers["tip"]!.addListener(() {
      tip = double.parse(textControllers["tip"]!.text);
      log("tip set as ${tip}");
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
      child: Column(children: <Widget>[
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

    return Container(
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
          SizedBox(height: 30),
          Expanded(
            child: card,
          ),
        ],
      ),
    );
  }

  ElevatedButton clearButton() {
    return ElevatedButton(
        onPressed: () {
          log("Clear data entry");
          textControllers.forEach((key, value) {
            value.clear();
          });
          tip = null;
          tax = null;
          numPeople = null;
        },
        child: Text("Clear"));
  }

  ///Submit button for the [DataEntryPage] that is passed a [PageController] and navigates to page 1
  ElevatedButton submitButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          var logState = Provider.of<TransactionRecord>(context, listen: false);

          await logState.intializeRecord();

          if (dataFilled()) {
            logState.addTransaction(tax, tip, numPeople);
            widget.pageController.animateToPage(1,
                duration: Duration(milliseconds: 250), curve: Curves.easeIn);
          }
        },
        child: Text("Submit"));
  }
}

///Clear Button that removes the data from [NormalSplitState] state
class ClearButton extends StatelessWidget {
  final List<TextEditingController> textControllers;
  const ClearButton({
    super.key,
    required this.textControllers,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          //*DESIGN
          for (var controller in textControllers) {
            controller.clear();
          }
        },
        child: Text("Clear"));
  }
}

///Entry form that take in tip and stores in [NormalSplitState] state
class EntryForm extends StatelessWidget {
  final TextEditingController controller;
  final String prompt;
  final Icon icon;
  late final FilteringTextInputFormatter inputFormatter;

  EntryForm({
    super.key,
    required this.controller,
    required this.prompt,
    Icon? icon,
    String? filter,
  }) : icon = icon ?? Icon(Icons.face_2_sharp) {
    switch (filter) {
      case "money":
        inputFormatter =
            FilteringTextInputFormatter.allow(RegExp(r'(\d+)?\.?\d{0,2}'));
        break;
      case "integer":
        inputFormatter = FilteringTextInputFormatter.allow(RegExp(r"[0-9]"));
      default:
        null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          labelText: prompt,
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 5),
            child: icon,
          ),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          inputFormatter,
        ],
      ),
    );
  }
}
