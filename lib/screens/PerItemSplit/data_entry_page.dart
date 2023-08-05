
import 'package:abg_app/common/data_entry_custom_widgets.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import '../../common/expenses.dart';

class DataEntryPage extends StatefulWidget {
  DataEntryPage({super.key, required this.pageController});
  final PageController pageController;
  static const String routeName = "/dataEntry";

  @override
  State<DataEntryPage> createState() => _DataState();
}



class _DataState extends State<DataEntryPage> {
  int? numPeople = 0;
  List<Owner>? people;
  List<Item>? items;
  double? tax = 0.0;
  double? tip = 0.0;

  TextEditingController itemsController = TextEditingController();
  

  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
       title: Text("Enter Items"), 
       children: [
          
          ListView(
            children: [],
            )

        ],
    );
  }

  Widget entryForm(){

    return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              EntryForm(controller: itemsController, prompt: "Enter Item Name",),
            ],
          ),
        )
    );

  }

}
