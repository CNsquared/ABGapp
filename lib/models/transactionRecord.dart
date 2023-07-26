// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//persistence done but multiple efficeny checks need to be done
///Keeps track of all transations
class TransactionRecord extends ChangeNotifier {
  bool initialized;
  //late List<_Transaction> record; // !Remove allow null after testing
  late List expenses;

  int iD;
  TransactionRecord()
      : initialized = false,
        iD = 0;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _logFile async {
    final path = await _localPath;
    return File('$path/log.json');
  }

  //intializes each time enters logs
  // costly operation should proberely be relpleaced with an intialized boolean and then only runs the code if it hasnt before
  //TODO JSON HELL
  Future<void> intializeRecord() async {
    expenses = List.empty(growable: true);

    if (initialized) {
      log("Log file already initialized");
      return;
    }

    await _logFile.then((value) {
      try {
        String jsonString = value.readAsStringSync();
        if (jsonString != "") {
          List json = jsonDecode(jsonString);
          expenses = json.map((tagJson) => Expense.fromJson(tagJson)).toList();
          log("Set expenses as ${expenses.toString()}");
        } else {
          expenses = List.empty(growable: true);
          log("Log file blank");
        }
      } on PathNotFoundException {
        log("created log file");
        value.createSync(recursive: true);
        expenses = List.empty(growable: true);
      }
      initialized = true;
      log("intialization of log file complete");
    });
  }

  ///Adds a [_Transaction] into the record
  void addTransaction(tax, tip, numPeople) {
    var expense = Expense(
        iD: iD,
        date: DateTime.now(),
        splittingMethod: "TEMP",
        tax: tax,
        tip: tip,
        numPeople: numPeople);
    log("adding new expense to tracker");
    expenses.add(expense);

    //var transaction = _Transaction(iD, tax, tip, numPeople, DateTime.now());
    //record.add(transaction);

    iD++;
    //writes to file every time maybe only do it on exit
    writeRecord();
  }

  //rewrites every single log, should just appened
  void writeRecord() {
    log("writing record to log file");
    var json = jsonEncode(expenses);
    _logFile.then((value) {
      value.writeAsStringSync(json, mode: FileMode.write);
      log("wrote record to log file");
    });
  }
}

class Expense {
  //metadata
  int iD;
  DateTime? date;
  int numPeople;

  List<Owner> people;
  List<Item> items;
  double tax;
  double tip;
  String splittingMethod;

  Expense({
    required this.iD,
    this.date,
    required this.splittingMethod,
    required this.tax,
    required this.tip,
    required this.numPeople,
    List<Item>? items,
    List<Owner>? people,
  })  : items = items ?? List.empty(growable: true),
        people = people ?? List.empty(growable: true);

  factory Expense.fromJson(dynamic json) {
    var itemsObjsJson = json['items'] as List;
    List _items =
        itemsObjsJson.map((tagJson) => Item.fromJson(tagJson)).toList();

    var peopleObjsJson = json['people'] as List;
    List _people =
        peopleObjsJson.map((tagJson) => Owner.fromJson(tagJson)).toList();

    return Expense(
      iD: json['iD'] as int,
      splittingMethod: json["splittingMethod"] as String,
      items: _items as List<Item>,
      people: _people as List<Owner>,
      tax: json["tax"] as double,
      tip: json["tip"] as double,
      numPeople: json['numPeople'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> people = this.people.map((i) => i.toJson()).toList();
    List<Map> items = this.items.map((i) => i.toJson()).toList();

    return {
      'iD': iD,
      'numPeople': numPeople,
      /*'date': date,*/
      'people': people,
      'items': items,
      'tax': tax,
      'tip': tip,
      'splittingMethod': splittingMethod
    };
  }

  ///Widget that provides a UI for the user to edit the data scanned from the recipt
  /// be able to add items, edit items, delete items
  /// edit tax tip
  Widget editRecipt() {
    throw UnimplementedError();
  }

  ///Widget that provides UI for the user to assign an owner to each item
  Widget assignItemOwener() {
    throw UnimplementedError();
  }

  ///Widget the provides UI for editing who the owners are
  ///In the future this should be a sperate section where users enter who their friends are
  Widget editPeople() {
    throw UnimplementedError();
  }
}

class Item {
  Owner? owner;
  String name;
  double cost;

  Item({required this.name, this.owner, required this.cost});

  Item.fromJson(Map<String, dynamic> json)
      : owner = json['owner'] as Owner,
        name = json['name'] as String,
        cost = json['cost'] as double;

  Map<String, dynamic> toJson() {
    Map<String, dynamic>? owner =
        this.owner != null ? this.owner!.toJson() : null;

    return {'owner': owner, 'name': name, 'cost': cost};
  }

  void setOwner(Owner owner) {
    this.owner = owner;
  }
}

class Owner {
  List<Item> items;
  String name;
  double additionalCost;

  //String spliting method

  Owner({required this.name, List<Item>? items, this.additionalCost = 0})
      : items = items ?? List.empty(growable: true);

  factory Owner.fromJson(Map<String, dynamic> json) {
    var itemsObjsJson = json['tags'] as List;
    List _items =
        itemsObjsJson.map((tagJson) => Item.fromJson(tagJson)).toList();

    return Owner(
      items: _items as List<Item>,
      name: json['name'] as String,
      additionalCost: json['additionalCost'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> items = this.items.map((i) => i.toJson()).toList();
    return {'items': items, 'name': name, 'additionalCost': additionalCost};
  }

  // ! In order to update total cost the method needs to know how to spilt the cost, wether spilting the tax and tip evenly or per item
  // ! Design choice of passing down that information
  void _updateTotalCost() {}

  void addItem(Item item) {
    items.add(item);
    _updateTotalCost();
  }
}

// ! DO NOT USE DEPRECATING CLASS
///Data structure that hold information abotu each transaction
class _Transaction {
  int iD;
  DateTime? date;
  double tax;
  double tip;
  int numPeople;

  _Transaction(this.iD, this.tax, this.tip, this.numPeople, this.date);

  _Transaction.fromJson(Map<String, dynamic> json)
      : iD = json['iD'] as int,
        //date = json['date'] as DateTime,
        tax = json['tax'] as double,
        tip = json['tip'] as double,
        numPeople = json['numPeople'] as int;

  Map<String, dynamic> toJson() => {
        'iD': iD,
        /*'date': date,*/ 'tax': tax,
        'tip': tip,
        'numPeople': numPeople
      };
}
