import 'package:debtdiary/Debt.dart';
import 'package:flutter/material.dart';

class NewDebtDialog extends StatefulWidget {
  NewDebtDialog({Key key, this.id}) : super(key: key);

  final int id;

  _NewDebtDialogState createState() => _NewDebtDialogState();
}

const _AMOUNTERROR = 'Not a valid number';

class _NewDebtDialogState extends State<NewDebtDialog> {
  String _personName;
  String _reason;
  double _amount = 0;

  bool _showAmountError = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              if (_personName != null &&
                  _personName.isNotEmpty &&
                  _reason != null &&
                  _reason.isNotEmpty &&
                  _amount != 0)
                Navigator.pop(
                    context,
                    Debt(
                        amount: _amount,
                        toPersonID: _personName,
                        reason: _reason,
                        id: widget.id));
              else
                Navigator.pop(context, null);
            },
          ),
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context, null),
          ),
        ],
        content: Column(
          children: <Widget>[
            TextField(
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'person',
              ),
              onChanged: (value) => setState(() => _personName = value),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'amount',
                errorText: _showAmountError ? _AMOUNTERROR : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  double doubleValue = double.tryParse(value);

                  if (doubleValue == null) {
                    _amount = 0;
                    _showAmountError = true;
                  } else {
                    _amount = doubleValue;
                    _showAmountError = false;
                  }
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'reason'),
              onChanged: (value) => setState(() => _reason = value),
            )
          ],
        ));
  }
}
