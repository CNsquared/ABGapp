// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
  void addTransaction({required tax, required tip, required numPeople, required splittingMethod}) {
    var expense = Expense(
        iD: iD,
        date: DateTime.now(),
        splittingMethod: splittingMethod,
        tax: tax,
        tip: tip,
        numPeople: numPeople
    );

    log("adding new expense to tracker");
    expenses.add(expense);

    iD++;
    prefs.setInt('iD', iD);

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
