import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/transactionRecord.dart';

///Displays the logged transations in [TransactionRecord]
class Log extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var logState = context.watch<TransactionRecord>();

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
      body: FutureBuilder<void>(
        future: logState.intializeRecord(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: logState.record.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(logState.record[index].iD.toString()),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
