import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';


import '../common/expenses.dart';
import '../models/transaction_record.dart';

///Displays the logged transations in [TransactionRecord]
class Log extends StatelessWidget {

  static const String routeName = "/log";

  @override
  Widget build(BuildContext context) {
    var logState = context.watch<TransactionRecord>();
    var expenses = logState.expenses;


    log("current expenses to show: $expenses");

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
        itemBuilder: (context, index) {
          return ListTile(
            title: expenseCard(expense: expenses[index]),
          );
        },
      ),
    );
  }


  Widget expenseCard({required Expense expense}){

    return ExpansionTileCard(
       title: Text("Date: ${expense.date}"), 
       children: [
          Text("ID: ${expense.iD}"),
          Text("Tip: ${expense.tip}"),
          Text("Tax: ${expense.tax}"),
          Text("Num People: ${expense.numPeople}"),
          Text("People: ${expense.people}"),
        ],
    );
  }

}

