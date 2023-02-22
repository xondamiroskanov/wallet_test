import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet/widgets/costes_list_tile.dart';

import '../models/costes_model.dart';

class CostList extends StatelessWidget {
  final List<Costes> costes;
final Function delete;
  CostList(this.costes,this.delete);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 420,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(55), topRight: Radius.circular(50))),
        child: costes.length > 0
            ? ListView.builder(
                itemCount: costes.length,
                itemBuilder: (context, index) {
                  return CostesListTile(
                      costes[index].iconData,
                      costes[index].title,
                      costes[index].time,
                      costes[index].cost,
                  ValueKey(costes[index].id),
                  delete,
                    costes[index].id
                  );
                })
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Bu oyda xarajatlar yo'q",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black45,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                      child: Image.asset(
                    "assets/images/empty.png",
                    fit: BoxFit.cover,
                    width: 130,
                    height: 130,
                  ))
                ],
              ),
      ),
    );
  }
}
