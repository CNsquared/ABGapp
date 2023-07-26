import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/transactionRecord.dart';

///Displays the logged transations in [TransactionRecord]
class Log extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var logState = context.watch<TransactionRecord>();
    var expenses = logState.expenses;

    log("log of expenses: ${logState.expenses.elementAt(0) }");

    //Currently only shows Id number of each transaciton
    //Future show tax tip, num people, date? maybe drop down menu when you click on them to show more details
    //NEED TO IMPLEMENT BACK AND HOME BUTTON //BUGGING OUT CRASH WHEN NOT IN SCAFFOLD
    //DESIGN TEAM
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go("/home");
          },
        ),
      ),
      body: ListView.builder(
          itemCount: expenses.length,
          prototypeItem: ListTile(
            title: Text(expenses.first.iD.toString()),
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(expenses[index].iD.toString()),
            );
          },
        ),
          
    );
  }
}
