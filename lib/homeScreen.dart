// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:abg_app/homeScreenFactory.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:abg_app/main.dart';




class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _MyCustomFormState formState = _MyCustomFormState();
  
  @override
  Widget build(BuildContext context) {

 
   return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          homeScreenFactory.createTextInput("Tip", formState.tipController),
          homeScreenFactory.createTextInput("Tax", formState.taxController),
          homeScreenFactory.createSubmit(context),
          
        ],
      )),
    );
       
  }

}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends ChangeNotifier {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final taxController = TextEditingController();
  final tipController = TextEditingController();
  
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taxController.dispose();
    tipController.dispose();
    super.dispose();
  }

}


