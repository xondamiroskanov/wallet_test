import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletMonthDate extends StatelessWidget {
  final Function walletMonth;
  final DateTime walledMonthTime;

  WalletMonthDate(this.walletMonth, this.walledMonthTime);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        walletMonth(context);
      },
      child: Text(
        "${DateFormat('MMMM,  y').format(walledMonthTime)}",
        style: TextStyle(
             fontSize: 20, color: Colors.black87),
      ),
    );
  }
}
