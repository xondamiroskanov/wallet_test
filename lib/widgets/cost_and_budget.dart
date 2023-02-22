import 'package:flutter/material.dart';
import '../models/costes_model.dart';
import 'budget_part.dart';
import 'cost_list.dart';
class CostAndBudget extends StatelessWidget {
final List<Costes> costesModel;
final double totalCostMonth;
final Function delete;

CostAndBudget(this.totalCostMonth, this.costesModel,this.delete,);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Bu fayl xarajatlar royxatining yuqori qismi yani umummiy oylik
        BudgetPart(totalCostMonth),
        // Bu faylda xarajatlar yozilgan
        CostList(costesModel,delete)
      ],
    );
  }
}
