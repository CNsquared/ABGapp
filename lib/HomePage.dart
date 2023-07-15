
import 'dart:developer';

import 'package:abg_app/FinalPage.dart';
import 'package:abg_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DataEntryPage.dart';

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{

  String selectedIndex = "dataEntry";

  bool _checkFilled (BuildContext context){
   var appState = Provider.of<AbgAppState>(context, listen: false);
   return  appState.taxValue != -1 && appState.tipValue != -1 && appState.numPeople != -1;
  }

  @override
  Widget build(BuildContext context) {

   

    //checks if all values have been filled in by the user
    

   
    //determines which page to load up
    Widget page;
    switch (selectedIndex) {
      case "dataEntry":
        page = DataEntryPage();
        break;
      case "finalScreen":
        page = FinalPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    //loads the page
    return Container(
      color: Color.fromARGB(255, 155, 152, 152),
      child: Center(   
        child: Column(
          children: [
            page,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 179, 179, 179),
              ),
              child: const Text(
              'Submit',
               style: TextStyle(color: Color.fromARGB(255, 238, 232, 222)),
                  ),
              onPressed: () {
                  if(!_checkFilled(context)){
                      log("not submit because all fields not filled");
                  }
                  setState(() {
                  selectedIndex = "finalScreen";
                });



              },
            ),
          ],
        )
      ),
    );

  }

}

