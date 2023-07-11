import 'package:abg_app/homeScreenFactory.dart';
import 'package:abg_app/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AbgApp());
}

class AbgApp extends StatelessWidget{
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
        home: HomeScreen(),
      ),
    );
  }

}

class AbgAppState extends ChangeNotifier {

  var tipValue;
  var taxValue;

  void submitTaxTip(){


  }
  
}
