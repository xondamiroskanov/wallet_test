import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CostesListTile extends StatefulWidget {
  final IconData iconData;
  final String title;
  final DateTime time;
  final String cost;
  final Key key;
  final Function delete;
  final String id;
  CostesListTile(this.iconData, this.title, this.time, this.cost, this.key,this.delete,this.id)
      : super(key: key);

  @override
  State<CostesListTile> createState() => _CostesListTileState();
}

class _CostesListTileState extends State<CostesListTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.lightBlue,
        child: Padding(padding: EdgeInsets.all(16),
        child: Icon(Icons.delete_outline_sharp,color: Colors.white,)),
      ),
      key: widget.key,
      onDismissed: (direction) {
        widget.delete(widget.id);
      },
      direction: DismissDirection.endToStart,
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: Colors.lightBlue.shade400,
          radius: 24,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              widget.iconData,
              color: Colors.white,
            ),
          ),
        ),
        title: Text("${widget.title}"),
        subtitle: Text("${DateFormat('dd, MMMM, y').format(widget.time)}"),
        trailing: Text("${widget.cost} so'm"),
      ),
    );
  }
}
