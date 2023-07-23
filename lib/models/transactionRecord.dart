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
  DateTime? date;
  int numPeople;

  List<Item>? items;

  Expense({required this.iD, required this.date, required this.numPeople, List<Item>? items})
    : items = items ?? List.empty(growable: true);


}

class Item{

  String? owner;
  String name;
  double cost;

  Item({required this.name, this.owner, required this.cost});

}


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
        tax = json['tax'] as double,
        tip = json['tip'] as double,
        numPeople = json['numPeople'] as int;

  Map<String, dynamic> toJson() =>
      {'iD': iD, 'tax': tax, 'tip': tip, 'numPeople': numPeople};
}
