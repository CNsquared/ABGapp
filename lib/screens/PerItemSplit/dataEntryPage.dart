import 'dart:developer';

import 'package:abg_app/models/transactionRecord.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../common/expenses.dart';

class dataEntryPage extends StatefulWidget {
  dataEntryPage({super.key});

  @override
  State<dataEntryPage> createState() => _dataState();
}

class _dataState extends State<dataEntryPage> {
  int? numPeople;
  List<Owner>? people;
  List<Item>? items;
  double? tax;
  double? tip;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
