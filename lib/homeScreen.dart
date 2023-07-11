import 'package:flutter/material.dart';
import 'package:abg_app/homeScreenFactory.dart';
import 'package:provider/provider.dart';
import 'package:abg_app/main.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

   var appState = context.watch<AbgAppState>();

   return MyCustomForm();
       
  }

}



