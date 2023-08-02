// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:abg_app/common/date.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/expenses.dart';

//persistence done but multiple efficeny checks need to be done
///Keeps track of all transations
class TransactionRecord extends ChangeNotifier {
  bool initialized;
  late List expenses;
  late SharedPreferences prefs;
  late int iD;

  TransactionRecord() : initialized = false {
    log("Transaction Record created");
    expenses = List.empty(growable: true);
    intializeRecord();
  }

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
    if (initialized) {
      log("Log file already initialized");
      return;
    }

    prefs = await SharedPreferences.getInstance();
    iD = prefs.getInt('iD') ?? 0;

    await _logFile.then((value) {
      try {
        initialized = true;
        log("starting intialization of log file");
        String jsonString = value.readAsStringSync();
        log("jsonString: $jsonString");
        if (jsonString != "") {
          List json = jsonDecode(jsonString);
          expenses = json.map((expenseJson) => Expense.fromJson(expenseJson)).toList();
          log("Set expenses as ${expenses.toString()}");
        } else {
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
  Future<void> addTransaction({required tax, required tip, required numPeople, required splittingMethod}) async{
    var expense = Expense(
        iD: iD,
        date: Date.fromDate(DateTime.now()),  
        splittingMethod: splittingMethod,
        tax: tax,
        tip: tip,
        numPeople: numPeople
    );
    expenses.add(expense);
    log("added new expense to tracker: ${expenses.toString()}");

    iD++;
    prefs.setInt('iD', iD);

    //writes to file every time maybe only do it on exit
    await writeRecord();
    notifyListeners();
    
  }

  //rewrites every single log, should just appened
  Future<void> writeRecord() async {
    log("writing record to log file: ${expenses.toString()}");
    var json = jsonEncode(expenses.map((e) => e.toJson()).toList());
    log("json: $json");
    await _logFile.then((value) {
      value.writeAsStringSync(json, mode: FileMode.write);
      log("wrote record to log file");
    });
  }
}
