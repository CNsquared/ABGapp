import 'package:flutter/material.dart';

class confrimationScreen extends StatelessWidget {
  const confrimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color.fromARGB(255, 87, 78, 78),
      ),
      body: Center(
        child: Container(
          height: 5500.0,
          width: 10000,
          color: const Color.fromARGB(255, 255, 248, 231),
          child: Align(
            alignment: const Alignment(.85, .9),
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 87, 78, 78),
              // When the user presses the button, show an alert dialog containing
              // the text that the user has entered into the text field.
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Title'),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  backgroundColor: const Color.fromARGB(255, 255, 248, 231),
                  content: const Text('Description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Clear'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('Edit'),
                    ),
                  ],
                ),
              ),
              tooltip: 'Show me the value!',
              child: const Icon(Icons.monetization_on),
            ),
          ),
        ),
      ),
      //),
    );
  }
}
