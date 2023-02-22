import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:intl/intl.dart';

class AddModalBottomSheet extends StatefulWidget {
  final Function addNewCost;
  IconData? iconData;
  AddModalBottomSheet(this.addNewCost);

  @override
  State<AddModalBottomSheet> createState() => _AddModalBottomSheetState();
}

class _AddModalBottomSheetState extends State<AddModalBottomSheet> {
  DateTime? nowDate;
  TextEditingController costController = TextEditingController();
  TextEditingController titleContoller = TextEditingController();

  void addDayCalendar(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((chooseDay) {
      if (chooseDay != null) {
        setState(() {
          nowDate = chooseDay;
        });
      }
    });
  }

  void submit() {
    if (titleContoller.text.isEmpty ||
        costController.text.isEmpty ||
        nowDate == null) {
      return;
    }
    widget.addNewCost(titleContoller.text, costController.text, nowDate, widget.iconData);
    Navigator.of(context).pop();
  }
  void chooseIcon(BuildContext context) {
    FlutterIconPicker.showIconPicker(context).then((icon) => setState(() {
      if (icon != null) {
        widget.iconData = icon;
      }
    }));
  }
  @override
  Widget build(BuildContext context) {
    print(titleContoller.text);
    print(costController.text);
    print(nowDate);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          TextField(
            controller: titleContoller,
            decoration: InputDecoration(labelText: "Xarajat nomi"),
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            controller: costController,
            decoration: InputDecoration(labelText: "Xarajat miqdori"),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(nowDate == null
                  ? "Xarajat kuni tanlanmadi"
                  : "Xarajat kuni: ${DateFormat("dd,MMMM").format(nowDate!)}"),
              TextButton(
                onPressed: () {
                  addDayCalendar(context);
                },
                child: Text(
                  "Kunni tanlash",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.iconData == null
                  ? Text(
                      "Icon tanlang",
                      style: TextStyle(fontSize: 14),
                    )
                  : Icon(widget.iconData),
              TextButton(
                onPressed: () {
                  chooseIcon(context);
                },
                child: Text(
                  "Icon tanlanmagan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
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
                  submit();
                },
                child: Text("Kiritish"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
