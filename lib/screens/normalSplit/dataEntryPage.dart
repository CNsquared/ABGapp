import 'package:abg_app/models/normalSplitRecipt.dart';
import 'package:abg_app/models/transactionRecord.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

///Takes in user input of what the tax, tip and number of people is
class DataEntryPage extends StatelessWidget {
  late PageController pageController;

  DataEntryPage(PageController controller) {
    pageController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var card = Card(
      child: Column(children: <Widget>[
        PeopleEntryForm(),
        TipEntryForm(),
        TaxEntryForm(),
        SubmitButton(pageController: pageController),
        ClearButton(),
      ]),
    );

    return Container(
      //DESIGN TEAM
      padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
      child: Column(
        children: [
          //Design TEAM
          Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Add Values",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              )),
          //DESIGN TEAM
          SizedBox(height: 30),
          Expanded(
            child: card,
          ),
        ],
      ),
    );
  }
}

///Submit button for the [DataEntryPage] that is passed a [PageController] and navigates to page 1
class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          //DESIGN
          var appState = Provider.of<NormalSplitRecipt>(context, listen: false);
          var logState = Provider.of<TransactionRecord>(context, listen: false);
          if (appState.isFilled()) {
            logState.addTransaction(
                appState.taxValue, appState.taxValue, appState.numPeople);
            pageController.animateToPage(1,
                duration: Duration(milliseconds: 250), curve: Curves.easeIn);
          }
        },
        child: Text("Submit"));
  }
}

///Clear Button that removes the data from [NormalSplitRecipt] state

//Doesnt remove the data from the text entry forms
class ClearButton extends StatelessWidget {
  const ClearButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          //DESIGN
          var appState = Provider.of<NormalSplitRecipt>(context, listen: false);
          appState.clear();
        },
        child: Text("Clear"));
  }
}

///Entry form that take in tip and stores in [NormalSplitRecipt] state
class TipEntryForm extends StatelessWidget {
  const TipEntryForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<NormalSplitRecipt>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: TextFormField(
        onChanged: (text) {
          if (text != "") {
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

///Entry form that take in tax and stores in [NormalSplitRecipt] state
class TaxEntryForm extends StatelessWidget {
  const TaxEntryForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<NormalSplitRecipt>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: TextFormField(
        onChanged: (text) {
          if (text != "") {
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

///Entry form that take in People and stores in [NormalSplitRecipt] state
class PeopleEntryForm extends StatelessWidget {
  const PeopleEntryForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<NormalSplitRecipt>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: TextFormField(
        onChanged: (text) {
          if (text != "") {
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
        keyboardType: const TextInputType.numberWithOptions(
            decimal: false, signed: false),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
        ],
      ),
    );
  }
}
