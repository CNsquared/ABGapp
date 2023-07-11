// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'confrimationScreen.dart';
import 'main.dart';

class homeScreenFactory {
  static Padding createTextInput(String? inputName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: inputName,
          prefixIcon: const Padding(
              padding: EdgeInsetsDirectional.only(start: 20, top: 10),
              // ignore: prefer_const_constructors
              child: Text(
                "\$",
                style: TextStyle(fontSize: 25),
              )),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
        ],
      ),
    );
  }

  static ElevatedButton createSubmit(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 87, 78, 78),
      ),
      child: const Text(
        'Submit',
        style: TextStyle(color: Color.fromARGB(255, 238, 232, 222)),
      ),
      onPressed: () {
        Navigator.push(
          context,

          MaterialPageRoute(builder: (context) => const confrimationScreen()),
        );
      },
    );
  }

}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          homeScreenFactory.createTextInput("Tip"),
          homeScreenFactory.createTextInput("Tax"),
          homeScreenFactory.createSubmit(context),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 87, 78, 78),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(color: Color.fromARGB(255, 238, 232, 222)),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text the that user has entered by using the
                    // TextEditingController.
                    content: Text(myController.text),
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              style: const TextStyle(fontSize: 20),
              controller: myController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "test2",
                prefixIcon: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 20, top: 10),
                    // ignore: prefer_const_constructors
                    child: Text(
                      "\$",
                      style: TextStyle(fontSize: 25),
                    )),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
              ],
            ),
          ),
        ],
      )),
    );
   
  }
}
