import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'ABG App';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            style: TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tax',
              prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 20, top: 10),
                        child: Text("\$",
                                    style: TextStyle(fontSize: 25),)
                        ), 
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters:[ 
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
             ],
        

          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            style: TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tip',
              prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 20, top: 10),
                        child: Text("\$",
                                    style: TextStyle(fontSize: 25),)
                        ), 
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [ FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
            ],
            
          ),
        ),
      ],
    );
  }
}