
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class homeScreenFactory{

  static Padding createTextInput(String? inputName){
    

    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            style: const TextStyle(fontSize: 20),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: inputName,
              prefixIcon: const Padding(
                        padding: EdgeInsetsDirectional.only(start: 20, top: 10),
                        // ignore: prefer_const_constructors
                        child: Text("\$",
                                    style: TextStyle(fontSize: 25),)
                        ), 
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters:[ 
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
             ],
        

          ),
        );
  }
}