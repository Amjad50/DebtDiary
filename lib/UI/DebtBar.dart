import 'package:flutter/material.dart';
import 'package:debtdiary/Debt.dart';
import 'package:debtdiary/main.dart';

class DebtBar extends StatefulWidget {
  DebtBar({Key key, this.debt}) : super(key: key);

  final Debt debt;

  _DebtBarState createState() => _DebtBarState();
}

TextStyle _boldStyle(Color colorParam) => TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: colorParam,
    );

class _DebtBarState extends State<DebtBar> {
  // TODO: implement
  void _payHandler() {}

  // TODO: implement
  void _deleteHandler() {
    all.removeWhere((e) => e.id == widget.debt.id);
  }

  ListTile _getDataNode() {
    return ListTile(
      title: Text(
        widget.debt.toPersonID,
        style: _boldStyle(null),
      ),
      subtitle: Text(
        widget.debt.reason,
        maxLines: 2,
      ),
      trailing: Text(
        '${widget.debt.amount.abs()}',
        style: _boldStyle(widget.debt.amount < 0 ? Colors.red : Colors.green),
      ),
    );
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
              final Debt d = widget.debt;
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
      child: _getDataNode(),
    );
  }
}
