import 'package:abg_app/homeScreenFactory.dart';
import 'package:abg_app/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Log-IT',
    home: homeScreen(),
  ));
}
