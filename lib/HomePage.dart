
import 'dart:developer';

import 'package:abg_app/FinalPage.dart';
import 'package:abg_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DataEntryPage.dart';

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => HomePageState();

}

class HomePageState extends State<HomePage>{

  String selectedIndex = "dataEntry";

  bool _checkFilled (BuildContext context){
   var appState = Provider.of<AbgAppState>(context, listen: false);
   return  appState.taxValue != -1 && appState.tipValue != -1 && appState.numPeople != -1;
  }

  void selectIndex(page){
    if(_checkFilled(context)) {
      setState(() {
      selectedIndex = page;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    //determines which page to load up
    Column page;
    
    switch (selectedIndex) {
      case "dataEntry":
        page = Column(
          children: [
            DataEntryPage(),
            navigationButton("Submit"),   
          ],
        ); 
        break;
      case "finalScreen":
        page = Column(
          children: [
            FinalPage(),
          ],
        ); 
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    //loads the page
    return Container(
      color: Color.fromARGB(255, 155, 152, 152),
      child: Center(   
        child: Padding(
          padding:  EdgeInsets.fromLTRB(15, 100, 15, 150),
          child: Card(
            elevation: 15,
            child: Column(
              children: [
                page,
              ],
            ),
          ),
        )
      ),
    );

  }

  ElevatedButton navigationButton(String hint) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 179, 179, 179),
            ),
            child: Text(
            hint,
              style: TextStyle(color: Color.fromARGB(255, 238, 232, 222)),
                ),
            onPressed: () {
              selectIndex("finalScreen");
            }
          );
  }

}



