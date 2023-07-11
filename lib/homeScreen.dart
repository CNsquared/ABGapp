import 'package:flutter/material.dart';
import 'package:abg_app/homeScreenFactory.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

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
        ],
      )),
    );
  }
}

class homeScreenState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}