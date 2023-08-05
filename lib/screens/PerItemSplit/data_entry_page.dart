import 'dart:developer';

import 'package:abg_app/common/data_entry_custom_widgets.dart';
import 'package:abg_app/models/transaction_record.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/expenses.dart';

class DataEntryPage extends StatefulWidget {
  DataEntryPage({super.key, required this.pageController});
  final PageController pageController;
  static const String routeName = "/dataEntry";

  @override
  State<DataEntryPage> createState() => _DataState();
}

class _DataState extends State<DataEntryPage> {
  int? numPeople;
  List<Owner> people = List.empty(growable: true);
  List<Item> items = List.empty(growable: true);
  double? tax;
  double? tip;

  TextEditingController itemsController = TextEditingController();

  final Map<String, TextEditingController> textControllers = {
    "itemName": TextEditingController(),
    "itemCost": TextEditingController(),
    "numPeople": TextEditingController(),
    "tax": TextEditingController(),
    "tip": TextEditingController()
  };

  Item? item;

  @override
  void initState() {
    textControllers["itemName"]!.addListener(() {
      if (textControllers["itemName"]!.text != "") {
        item!.name = textControllers["itemName"]!.text;
        log("itemName set as ${item!.name}");
      }
    });
    textControllers["itemCost"]!.addListener(() {
      if (textControllers["itemCost"]!.text != "") {
        item!.cost = double.parse(textControllers["itemCost"]!.text);
        log("itemCost set as ${item!.cost}}");
      }
    });

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          //TODO: Limit how far it can expand down
          ExpansionTileCard(
            title: Text("Enter Items"),
            children: [
              ElevatedButton(
                  onPressed: () {
                    item = Item();
                    _showMyDialog();
                  },
                  child: Text("Add Item")
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(items[index].name!),
                      subtitle: Text(items[index].cost.toString()),
                    );
                  })
            ],
          ),
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
          clearButton(),
          submitButton(context)
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                EntryForm(
                  controller: textControllers["itemName"]!,
                  prompt: "Enter Item Name",
                  filter: "name",
                  icon: Icon(Icons.abc),
                ),
                EntryForm(
                    controller: textControllers["itemCost"]!,
                    prompt: "Enter Item Price",
                    filter: "money",
                    icon: Icon(Icons.attach_money_rounded)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  
                });
                items.add(item!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
        child: Text("Clear",
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color)));
  }

  ///Submit button for the [DataEntryPage] that is passed a [PageController] and navigates to page 1
  ElevatedButton submitButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          var logState = Provider.of<TransactionRecord>(context, listen: false);
          FocusScope.of(context).unfocus();
          await logState.intializeRecord();

          if (dataFilled()) {
            await logState.addTransaction(
                tax: tax,
                tip: tip,
                numPeople: numPeople,
                items: items,
                splittingMethod: "equalTaxTip");
            widget.pageController.animateToPage(1,
                duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
          }
        },
        child: Text("Submit",
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color)));
  }

  bool dataFilled() {
    return (numPeople != null && tax != null && tip != null);
  }
}
