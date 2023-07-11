// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'confrimationScreen.dart';
import 'main.dart';

class homeScreenFactory {
  static Padding createTextInput(String? inputName, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)
          ),
          labelText: inputName,
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
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
        ],
      ),
    );
  }

  
  static ElevatedButton createSubmit(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 87, 78, 78),
      ),
      child: const Text(
        'Submit',
        style: TextStyle(color: Color.fromARGB(255, 238, 232, 222)),
      ),
      onPressed: () {
        Navigator.push(
          context,

          MaterialPageRoute(builder: (context) => const confrimationScreen()),
        );
      },
    );
  }

}

