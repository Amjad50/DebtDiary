import 'package:debtdiary/UI/DebtBar.dart';

class Debt {
  static const String ID_SQL_NAME = 'id',
      PERSON_SQL_NAME = 'person',
      AMOUNT_SQL_NAME = 'amount',
      TIME_SQL_NAME = 'time',
      REASON_SQL_NAME = 'reason';

  final int id;
  final double amount;
  final String toPersonID;
  final String reason;
  final String time;

  Debt({this.id, this.toPersonID, this.amount, this.reason, time})
      : this.time = time ?? DateTime.now().toUtc().toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      ID_SQL_NAME: id,
      PERSON_SQL_NAME: toPersonID,
      AMOUNT_SQL_NAME: amount,
      REASON_SQL_NAME: reason,
      TIME_SQL_NAME: time,
    };
  }

  DebtBar getUIView() {
    return DebtBar(debt: this);
  }
}
