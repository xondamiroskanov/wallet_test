import 'package:flutter/material.dart';

class Costes {
  final String title;
  final String id;
  final String cost;
  final DateTime time;
  final IconData iconData;

  Costes(
      {required this.title,
      required this.id,
      required this.cost,
      required this.time,
      this.iconData = Icons.cabin});
}

class CostesModel {
  List<Costes> _costList = [
    Costes(title: "Yo'lkira", id: "c1", cost: "3600", time: DateTime.now()),
    Costes(title: "Obed", id: "c2", cost: "15000", time: DateTime.now()),
    Costes(title: "Cola", id: "c3", cost: "10000", time: DateTime.now()),
    Costes(title: "Kechki", id: "c4", cost: "12000", time: DateTime.now()),

  ];

  List<Costes> costList() {
    return _costList;
  }

  void addNewCost(String title, String cost, DateTime time,IconData iconData) {
    _costList.add(Costes(
        title: title, id: "${costList().length + 1}", cost: cost, time: time,iconData: iconData));
  }

  double totalCostMonth(DateTime costMonthTime) {
    return dateCost(costMonthTime).fold(0, (previousValue, element) {
      return previousValue + int.parse(element.cost);
    });
  }

  List<Costes> dateCost(DateTime time) {
    return _costList.where((dateTime) {
      return dateTime.time.year == time.year &&
          dateTime.time.month == time.month;
    }).toList();
  }

  void deleteCost(String id) {
    _costList.removeWhere((deleteId) {
      return deleteId.id == id;
    });
  }

}
