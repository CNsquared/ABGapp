// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:abg_app/homeScreenFactory.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:abg_app/main.dart';
import 'dart:developer';




class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _MyCustomFormState formState = _MyCustomFormState();
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 238, 232, 222),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 225, 210, 173),
              ),
            alignment: Alignment.center,
            width: 300,
            height: 400,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            homeScreenFactory.createTextInput("Tip", formState.tipController),
            homeScreenFactory.createTextInput("Tax", formState.taxController),
            homeScreenFactory.createSubmit(context),
            ],
          ),
          ),
        ),
      );
       
  }

}

// This class holds the data related to the Form.
class _MyCustomFormState extends ChangeNotifier {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final taxController = TextEditingController();
  final tipController = TextEditingController();
  final displayController = TextEditingController();

  var tax;
  var tip;
  
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taxController.dispose();
    tipController.dispose();
    super.dispose();
  }

  void saveData(){
    
    tax = taxController.text;
    tip = tipController.text;
    log("it work");

    notifyListeners();

  }

}


