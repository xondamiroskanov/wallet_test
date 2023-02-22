import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:wallet/models/costes_model.dart';
import 'package:wallet/widgets/bottom_sheet.dart';
import 'package:wallet/widgets/cost_and_budget.dart';
import 'package:wallet/widgets/total_cost.dart';
import 'package:wallet/widgets/walled_month_date.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime walledMonthTime = DateTime.now();

  CostesModel costesModel = CostesModel();

  void walletMonth(BuildContext context) {
    showMonthPicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2025))
        .then((nowTime) {
      setState(() {
        if (nowTime != null) {
          walledMonthTime = nowTime;
        }
      });
    });
  }

  void previousMonth() {
    if (walledMonthTime.year == 2020 && walledMonthTime.month == 1) {
      return;
    }
    setState(() {
      walledMonthTime = DateTime(
          walledMonthTime.year, walledMonthTime.month - 1, walledMonthTime.day);
    });
  }

  void nextMonth() {
    if (walledMonthTime.year == 4 &&
        walledMonthTime.month == DateTime
            (2025)
            .month) {
      return;
    }
    setState(() {
      walledMonthTime = DateTime(
          walledMonthTime.year, walledMonthTime.month + 1, walledMonthTime.day);
    });
  }

  void addModalCost(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddModalBottomSheet(addCost);
        });
  }

  void addCost(String title,  String cost, DateTime time){
    setState(() {
      costesModel.addNewCost(title, cost, time);
    });
  }
  void delete(String id){
    setState(() {
      costesModel.deleteCost(id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6CA0FF),
        title: Text("Mening hamyonim"),
      ),
      body: Column(
        children: [
          WalletMonthDate(walletMonth, walledMonthTime),
          SizedBox(
            height: 20,
          ),
          TotalCost(costesModel.totalCostMonth(walledMonthTime), previousMonth, nextMonth, walledMonthTime),
          const SizedBox(
            height: 32,
          ),
          // Bu fayl ummumiy xarajatlar va oylik yozilgan
          CostAndBudget(costesModel.totalCostMonth(walledMonthTime), costesModel.dateCost(walledMonthTime),delete)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addModalCost(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
