// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:abg_app/homeScreenFactory.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Log-It",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 225, 210, 173),
              ),
              alignment: Alignment.center,
              width: 325,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  homeScreenFactory.createTextInput(
                      "People", formState.tipController),
                  homeScreenFactory.createTextInput(
                      "Tax", formState.taxController),
                  homeScreenFactory.createTextInput(
                      "Tip", formState.displayController),
                  homeScreenFactory.createSubmit(context, formState.saveData),
                ],
              ),
            ),
            SizedBox(height: 100),
          ],
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

  void saveData() {
    tax = taxController.text;
    tip = tipController.text;
    log("it work");

    notifyListeners();
  }
}
