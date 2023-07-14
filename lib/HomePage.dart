
import 'package:abg_app/FinalScreen.dart';
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

  @override
  Widget build(BuildContext context) {

   
    
    Widget page;
    switch (selectedIndex) {
      case "dataEntry":
        page = DataEntryPage();
        break;
      case "finalScreen":
        page = FinalScreen();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

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

