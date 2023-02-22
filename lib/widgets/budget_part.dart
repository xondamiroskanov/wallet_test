import 'package:flutter/material.dart';

class BudgetPart extends StatefulWidget {
  final double totalCostMonth;
  BudgetPart(this.totalCostMonth);

  @override
  State<BudgetPart> createState() => _BudgetPartState();
}

class _BudgetPartState extends State<BudgetPart> {
  TextEditingController amountController = TextEditingController();
   double monthAmount = 1000000;
  num amountPersentage() {
    return (widget.totalCostMonth * 100) / monthAmount;
  }
  void amountMonthText(double amountMOnth){
    setState(() {
      monthAmount = amountMOnth;

    });
  }
  @override
  void initState() {
    amountController.text = monthAmount.toStringAsFixed(0);
    super.initState();
  }
  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
  void inputAmount(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  TextField(
                    controller: amountController,
                    decoration: InputDecoration(
                        labelText: "Oylik daromadingizni kiriting"),
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("BEKOR QILISH"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                            amountMonthText(double.parse(amountController.text));
                            Navigator.of(context).pop();

                        },
                        child: Text("Kiritish"),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 520,
      decoration: BoxDecoration(
        color: Color(0xFFEFF0FB),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(55),
          topLeft: Radius.circular(55),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Oylik daromad:"),
                TextButton.icon(
                  onPressed: () {
                    inputAmount(context);
                  },
                  label: Text(monthAmount.toString()),
                  icon: Icon(Icons.edit),
                ),
                SizedBox(
                  width: 120,
                ),
                Expanded(
                  child: Text(amountPersentage() >= 100
                      ? "Xarajatlaringiz limitga yetdi"
                      : '${amountPersentage()} %'),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              width: double.infinity,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: FractionallySizedBox(
                heightFactor: 2,
                widthFactor: amountPersentage() / 100,
                alignment: Alignment.centerLeft,
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.lightBlue,
                      Colors.white10,
                      Colors.lightBlue
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
