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
  late List<_Transaction> record;
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
  Future<void> intializeRecord() async {

    if(initialized){ log("Log file already initialized"); return; }

    await _logFile.then((value) {
      try {
        String jsonString = value.readAsStringSync();
        if (jsonString != "") {
          List json = jsonDecode(jsonString);
          record =
              json.map((tagJson) => _Transaction.fromJson(tagJson)).toList();
          log("Set record as ${record.toString()}");
        } else {
          record = List.empty(growable: true);
          log("Log file blank");
        }
      } on PathNotFoundException {
        log("created log file");
        value.createSync(recursive: true);
      }
      initialized = true;
      log("intialization of log file complete");
    });


  }

  ///Adds a [_Transaction] into the record
  void addTransaction(tax, tip, numPeople) {
    var transaction = _Transaction(iD, tax, tip, numPeople, DateTime.now());
    record.add(transaction);

    iD++;
    //writes to file every time maybe only do it on exit
    writeRecord();
  }

  //rewrites every single log, should just appened
  void writeRecord() {
    log("writing record to log file");
    var json = jsonEncode(record);
    _logFile.then((value) {
      value.writeAsStringSync(json, mode: FileMode.write);
      log("wrote record to log file");
    });
  }
}




class Expense{

  //metadata
  int iD;
  DateTime date;
  //int numPeople; //if keep track of people dont need numPeople

  List<Owner>? people;
  List<Item>? items;
  double tax;
  double tip;
  String splittingMethod;
  
  List<Owner>? get getPeople => this.people;

  set setPeople(List<Owner>? people) => this.people = people;

  get getItems => this.items;

  set setItems( items) => this.items = items;

  get getTax => this.tax;

  set setTax( tax) => this.tax = tax;

  get getTip => this.tip;

  set setTip( tip) => this.tip = tip;

  Expense({required this.iD, required this.date, required this.splittingMethod, required this.tax, required this.tip, List<Item>? items, List<Owner>? people})
    : items = items ?? List.empty(growable: true),
      people = people ?? List.empty(growable: true);

  


}

class Item{

  Owner? owner;
  String name;
  double cost;

  Item({required this.name, this.owner, required this.cost});

  void setOwner(Owner owner){
    this.owner = owner;
  }




}

class Owner{

  List<Item> items;
  String name;
  double additionalCost;

  //String spliting method

  Owner({required this.name, List<Item>? items, this.additionalCost = 0})
    : items = items ?? List.empty(growable: true);

  // ! In order to update total cost the method needs to know how to spilt the cost, wether spilting the tax and tip evenly or per item
  // ! Design choice of passing down that information
  void _updateTotalCost(){


  }



  void addItem(Item item){
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
        date = json['date'] as DateTime,
        tax = json['tax'] as double,
        tip = json['tip'] as double,
        numPeople = json['numPeople'] as int;

  Map<String, dynamic> toJson() =>
      {'iD': iD, 'date': date, 'tax': tax, 'tip': tip, 'numPeople': numPeople};
}
