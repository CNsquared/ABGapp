import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//persistence done but multiple efficeny checks need to be done
///Keeps track of all transations
class TransactionRecord extends ChangeNotifier {

  bool initialized = false;
  List<_Transaction> record = List.empty(growable: true); 
  int iD = 0;

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

    await _logFile.then((value) {
      

      try{
        String jsonString = value.readAsStringSync();
        if(jsonString != ""){
          List json = jsonDecode(jsonString);
          record = json.map((tagJson) => _Transaction.fromJson(tagJson)).toList();
          log("Set record as ${record.toString()}");
        }
        else{
          record = List.empty(growable: true);
          log("Log file blank");
        }
      }
      on PathNotFoundException{
        log("created log file");
        value.createSync(recursive: true);
      }
    } );

  }
  
  ///Adds a [_Transaction] into the record
  void addTransaction(tax, tip, numPeople) {
    var transaction = _Transaction(iD, tax, tip, numPeople);
    record.add(transaction);
    
    iD++;
    //writes to file every time maybe only do it on exit
    writeRecord();
  }

  //rewrites every single log, should just appened
  void writeRecord(){
    log("writing record to log file");
    var json = jsonEncode(record);
    _logFile.then((value){
      value.writeAsStringSync(json, mode: FileMode.write);
      log("wrote record to log file");
    });

  }


}

///Data structure that hold information abotu each transaction
class _Transaction {
  int iD;
  DateTime? date;
  double tax;
  double tip;
  int numPeople;

  _Transaction(this.iD, this.tax, this.tip, this.numPeople);

  _Transaction.fromJson(Map<String, dynamic> json)
      : iD = json['iD'] as int,
        tax = json['tax'] as double,
        tip = json['tip'] as double,
        numPeople = json['numPeople'] as int;
  
    Map<String, dynamic> toJson() => {
        'iD': iD,
        'tax': tax,
        'tip': tip,
        'numPeople': numPeople
      };

}
