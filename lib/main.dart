import 'dart:developer';

import 'package:abg_app/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const AbgApp());
}

class AbgApp extends StatelessWidget {
  const AbgApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AbgAppState(),
      child: MaterialApp(
        title: 'Log It',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: HomePage(),
      ),
    );
  }
}

class AbgAppState extends ChangeNotifier {
  int numPeople  = -1;
  double tipValue = -1;
  double taxValue = -1;

  void setTax(double parse) {
    log(parse.toString());
    taxValue = parse ;
  }
  void setTip(double parse) {
    log(parse.toString());
    tipValue = parse;
  }
  void setNumPeople(int parse) {
    log(parse.toString());
    numPeople = parse;
  }

  void submit(){
    if(numPeople != null && tipValue != null && taxValue != null){
      notifyListeners();
    }
    else{
      log("Not all parameters were filled");
    }
    
  }
}
