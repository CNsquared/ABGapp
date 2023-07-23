import 'dart:developer';

import 'package:flutter/material.dart';

///Keeps track of user entered information about normal split transactions
class NormalSplitRecipt extends ChangeNotifier {
  int numPeople = -1;
  double tipValue = -1;
  double taxValue = -1;

  void clear() {
    numPeople = -1;
    tipValue = -1;
    taxValue = -1;
  }

  void setTax(double parse) {
    log(parse.toString());
    taxValue = parse;
  }

  void setTip(double parse) {
    log(parse.toString());
    tipValue = parse;
  }

  void setNumPeople(int parse) {
    log("num of peoples set as $parse");
    numPeople = parse;
  }

  bool isFilled() {
    return (numPeople != -1 && tipValue != -1 && taxValue != -1);
  }
}
