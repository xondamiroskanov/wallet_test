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

  bool isLand = false;

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
        walledMonthTime.month == DateTime(2025).month) {
      return;
    }
    setState(() {
      walledMonthTime = DateTime(
          walledMonthTime.year, walledMonthTime.month + 1, walledMonthTime.day);
    });
  }

  void addModalCost(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) {
          return AddModalBottomSheet(
            addCost,
          );
        });
  }

  void addCost(String title, String cost, DateTime time, IconData iconData) {
    setState(() {
      costesModel.addNewCost(title, cost, time, iconData);
    });
  }

  void delete(String id) {
    setState(() {
      costesModel.deleteCost(id);
    });
  }

  Widget switchLandScape() {
    return isLand
        ? swatchConstAndBudget()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Xarajatlar ro'yxatini ko'rish"),
                  Switch(
                      value: isLand,
                      onChanged: (value) {
                        setState(() {
                          isLand = value;
                        });
                      }),
                ],
              ),
              WalletMonthDate(walletMonth, walledMonthTime),
              const SizedBox(
                height: 20,
              ),
              TotalCost(costesModel.totalCostMonth(walledMonthTime),
                  previousMonth, nextMonth, walledMonthTime),
            ],
          );
  }

  Widget swatchConstAndBudget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Xarajatlar ro'yxatini ko'rish"),
            Switch(
                value: isLand,
                onChanged: (value) {
                  setState(() {
                    isLand = value;
                  });
                }),
          ],
        ),
        CostAndBudget(
          costesModel.totalCostMonth(walledMonthTime),
          costesModel.dateCost(walledMonthTime),
          delete,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6CA0FF),
        title: Text("Mening hamyonim"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLandscape
                ? switchLandScape()
                : Center(
                    child: Column(
                      children: [
                        WalletMonthDate(walletMonth, walledMonthTime),
                        SizedBox(
                          height: 20,
                        ),
                        TotalCost(costesModel.totalCostMonth(walledMonthTime),
                            previousMonth, nextMonth, walledMonthTime),
                        SizedBox(
                          height: 24,
                        ),
                        CostAndBudget(
                          costesModel.totalCostMonth(walledMonthTime),
                          costesModel.dateCost(walledMonthTime),
                          delete,
                        ),
                      ],
                    ),
                  ),
            // ? Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text("Xarajatlar ro'yxatini ko'rish"),
            //           Switch(
            //               value: isLand,
            //               onChanged: (value) {
            //                 setState(() {
            //                   isLand = value;
            //                 });
            //               }),
            //         ],
            //       ),
            //       WalletMonthDate(walletMonth, walledMonthTime),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       TotalCost(costesModel.totalCostMonth(walledMonthTime),
            //           previousMonth, nextMonth, walledMonthTime),
            //     ],
            //   )
            // : Column(
            //     children: [
            //       WalletMonthDate(walletMonth, walledMonthTime),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       TotalCost(costesModel.totalCostMonth(walledMonthTime),
            //           previousMonth, nextMonth, walledMonthTime),
            //       CostAndBudget(
            //         costesModel.totalCostMonth(walledMonthTime),
            //         costesModel.dateCost(walledMonthTime),
            //         delete,
            //       ),
            //     ],
            //   ),
            const SizedBox(
              height: 32,
            ),
            // Bu fayl ummumiy xarajatlar va oylik yozilgan
          ],
        ),
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
