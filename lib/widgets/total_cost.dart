import 'package:flutter/material.dart';

class TotalCost extends StatelessWidget {
  final double totalCostMonth;
  final Function() previouMonth;
  final Function() nextMonth;
  final DateTime walledMonthTime;

  TotalCost(this.totalCostMonth, this.previouMonth, this.nextMonth, this.walledMonthTime);

  @override
  Widget build(BuildContext context) {
    final isLastDate = walledMonthTime.year == DateTime(2024).year &&
        walledMonthTime.month == DateTime(2024).month;
    final isFirstDate =
        walledMonthTime.year == 2020 && walledMonthTime.month == 1;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2, color: isFirstDate ? Colors.grey : Colors.green),
                borderRadius: BorderRadius.circular(30)),
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                previouMonth();
              },
              icon: isFirstDate
                  ? Icon(
                      Icons.arrow_left,
                      size: 30,
                      color: Colors.grey,
                    )
                  : Icon(
                      Icons.arrow_left,
                      size: 30,
                      color: Colors.green,
                    ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${totalCostMonth}",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Text("so'm",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2, color: isLastDate ? Colors.grey : Colors.green),
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                nextMonth();
              },
              icon: Icon(
                Icons.arrow_right,
                size: 30,
                color: isLastDate ? Colors.grey : Colors.green,
              ),
            ),
          )
        ],
      ),
    );
  }
}
