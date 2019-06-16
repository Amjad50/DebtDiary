import 'package:flutter/material.dart';
import 'package:debtdiary/Debt.dart';
import 'package:debtdiary/main.dart';

class DebtBar extends StatefulWidget {
  DebtBar({Key key, this.debt}) : super(key: key);

  final Debt debt;

  _DebtBarState createState() => _DebtBarState();
}

class _DebtBarState extends State<DebtBar> {
  bool _expanded = false;

  // TODO: implement
  void _payHandler() {}

  // TODO: implement
  void _deleteHandler() {
    all.removeWhere((e) => e.id == widget.debt.id);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          _payHandler();
        } else if (direction == DismissDirection.endToStart) {
          _deleteHandler();
        }

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
              'data ${widget.debt.id} ${direction == DismissDirection.startToEnd ? "payed" : "deleted"}'),
          action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              final Debt d = Debt(
                id: widget.debt.id,
                toPersonID: widget.debt.toPersonID,
                amount: widget.debt.amount,
                reason: widget.debt.reason,
              );
              setState(() {
                // TODO: add remove implementation in DB
                // await db.insertDebt(d).then((_) {
                all.insert(all.length, d);
                // });
              });
            },
          ),
          duration: Duration(
            seconds: 2,
          ),
        ));
      },
      background: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.green,
        child: Icon(Icons.payment),
        alignment: Alignment.centerLeft,
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.redAccent,
        child: Icon(Icons.delete),
        alignment: Alignment.centerRight,
      ),
      child: ExpansionTile(
        backgroundColor: Colors.black12,
        title: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(
                widget.debt.amount > 0
                    ? Icons.add_circle_outline
                    : Icons.remove_circle_outline,
                size: 35,
              ),
              // ),
              Text(
                "${widget.debt.amount.abs()}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.debt.toPersonID}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 10,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  widget.debt.reason,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(widget.debt.time)
              ],
            ),
          )
        ],
      ),
    );
  }
}
