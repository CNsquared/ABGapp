import 'dart:developer';

import 'package:abg_app/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';

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
  var numPeople;
  var tipValue;
  var taxValue;

  void setTax(double parse) {
    log(parse.toString());
    numPeople = parse;
  }
  void setTip(double parse) {
    log(parse.toString());
    tipValue = parse;
  }
  void setNumPeople(int parse) {
    log(parse.toString());
    taxValue = parse;
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
