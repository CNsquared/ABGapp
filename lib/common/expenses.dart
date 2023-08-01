import 'dart:developer';

import 'package:abg_app/common/paymentCalculator.dart';
import 'package:flutter/material.dart';

class Expense {
  //metadata
  int iD;
  DateTime? date;
  int numPeople;

  List<Owner> people;
  List<Item> items;
  double tax;
  double tip;
  String splittingMethod;

  Expense({
    required this.iD,
    this.date,
    required this.splittingMethod,
    required this.tax,
    required this.tip,
    required this.numPeople,
    List<Item>? items,
    List<Owner>? people,
  })  : items = items ?? List.empty(growable: true),
        people = people ?? List.empty(growable: true) {
    calculateCostPerPerson();
  }

  void calculateCostPerPerson() {
    log("Calculating cost per person");
    switch (splittingMethod) {
      case ("equal"):
        double sum = tax + tip;
        for (Item i in items) {
          sum += i.cost;
        }

        double amountPerPerson =
            PaymentCalculator.splitValue(value: sum, numOfPeople: numPeople);

        if (people.isEmpty) {
          people.add(Owner(name: "DEFAULT"));
        }

        for (Owner o in people) {
          o.cost = amountPerPerson;
        }
        break;

      case ("perItem"):
      case ("equalTaxTip"):
      default:
        var taxTip = tax + tip;

        double amountPerPerson =
            PaymentCalculator.splitValue(value: taxTip, numOfPeople: numPeople);

        if (people.isEmpty) {
          people.add(Owner(name: "DEFAULT"));
        }

        for (Owner o in people) {
          o.cost += amountPerPerson;
        }
    }
  }

  factory Expense.fromJson(dynamic json) {
    var itemsObjsJson = json['items'] as List;
    List items =
        itemsObjsJson.map((tagJson) => Item.fromJson(tagJson)).toList();

    var peopleObjsJson = json['people'] as List;
    List people =
        peopleObjsJson.map((tagJson) => Owner.fromJson(tagJson)).toList();

    return Expense(
      iD: json['iD'] as int,
      splittingMethod: json["splittingMethod"] as String,
      items: items as List<Item>,
      people: people as List<Owner>,
      tax: json["tax"] as double,
      tip: json["tip"] as double,
      numPeople: json['numPeople'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> people = this.people.map((i) => i.toJson()).toList();
    List<Map> items = this.items.map((i) => i.toJson()).toList();

    return {
      'iD': iD,
      'numPeople': numPeople,
      /*'date': date,*/
      'people': people,
      'items': items,
      'tax': tax,
      'tip': tip,
      'splittingMethod': splittingMethod
    };
  }

  ///Widget that provides a UI for the user to edit the data scanned from the recipt
  /// be able to add items, edit items, delete items
  /// edit tax tip
  Widget editRecipt() {
    throw UnimplementedError();
  }

  ///Widget that provides UI for the user to assign an owner to each item
  Widget assignItemOwener() {
    throw UnimplementedError();
  }

  ///Widget the provides UI for editing who the owners are
  ///In the future this should be a sperate section where users enter who their friends are
  Widget editPeople() {
    throw UnimplementedError();
  }
}

class Item {
  Owner? owner;
  String name;
  double cost;

  Item({required this.name, this.owner, required this.cost});

  Item.fromJson(Map<String, dynamic> json)
      : owner = json['owner'] as Owner,
        name = json['name'] as String,
        cost = json['cost'] as double;

  Map<String, dynamic> toJson() {
    Map<String, dynamic>? owner =
        this.owner != null ? this.owner!.toJson() : null;

    return {'owner': owner, 'name': name, 'cost': cost};
  }

  void setOwner(Owner owner) {
    this.owner = owner;
  }
}

class Owner {
  List<Item> items;
  String name;
  double cost;

  //String spliting method

  Owner({required this.name, List<Item>? items, this.cost = 0})
      : items = items ?? List.empty(growable: true) {
    cost = calculateTotalItemCost();
  }

  double calculateTotalItemCost() {
    log( "Calculating total item cost");
    var sum = 0.0;

    for (Item i in items) {
      sum += i.cost;
    }

    return sum;
  }

  factory Owner.fromJson(Map<String, dynamic> json) {
    var itemsObjsJson = json['items'] as List;
    List items =
        itemsObjsJson.map((tagJson) => Item.fromJson(tagJson)).toList();

    return Owner(
      items: items as List<Item>,
      name: json['name'] as String,
      cost: json['cost'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> items = this.items.map((i) => i.toJson()).toList();
    return {'items': items, 'name': name, 'cost': cost};
  }

  // ! In order to update total cost the method needs to know how to spilt the cost, wether spilting the tax and tip evenly or per item
  // ! Design choice of passing down that information
  void _updateTotalCost(Item item) {
    cost += item.cost;
  }

  void addItem(Item item) {
    items.add(item);
    _updateTotalCost(item);
  }
}
