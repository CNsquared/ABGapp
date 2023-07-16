

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class DataEntryPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children:<Widget>[ 
        SizedBox(height: 50), 
        Card(
          elevation: 50,
          child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Text("Log It", style: TextStyle(fontSize: 32)),
                SizedBox(height: 30),
                PeopleEntryForm(),
                TipEntryForm(),
                TaxEntryForm(),
                SizedBox(height: 100), 
              ]
          ),
        ),
        SizedBox(height: 40),
      ]
    );

  }

}


class TipEntryForm extends StatelessWidget{

  const TipEntryForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AbgAppState>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: TextFormField(
        onChanged: (text) {
          if(text != "") {
            appState.setTip(double.parse(text));
          }
        },
        style: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          labelText: "Tip",
          prefixIcon: const Padding(
              padding: EdgeInsetsDirectional.only(start: 20, top: 10),
              // ignore: prefer_const_constructors
              child: Text(
                "\$",
                style: TextStyle(fontSize: 25),
              )),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'(\d+)?\.?\d{0,2}')),
        ],
      ),
    );
  }
}

class TaxEntryForm extends StatelessWidget{

  const TaxEntryForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AbgAppState>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: TextFormField(
        onChanged: (text) {
          if(text != "") {
            appState.setTax(double.parse(text));
          }
        },
        style: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          labelText: "Tax",
          prefixIcon: const Padding(
              padding: EdgeInsetsDirectional.only(start: 20, top: 10),
              // ignore: prefer_const_constructors
              child: Text(
                "\$",
                style: TextStyle(fontSize: 25),
              )),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'(\d+)?\.?\d{0,2}')),
        ],
      ),
    );
  }
}

class PeopleEntryForm extends StatelessWidget{

  const PeopleEntryForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    var appState = context.watch<AbgAppState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: TextFormField(
        onChanged: (text) {
          if(text != "") {
            appState.setNumPeople(int.parse(text));
          }
        },
        style: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 5),
            child: Icon(Icons.person),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          labelText: "Number of People",
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
        ],
      ),
    );
  }
}


class SubmitButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 87, 78, 78),
      ),
      child: const Text(
        'Submit',
        style: TextStyle(color: Color.fromARGB(255, 238, 232, 222)),
      ),
      onPressed: () {
        

      },
    );
  }
}