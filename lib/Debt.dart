class Debt {

  static const String IDNAME = 'id',
    PERSONNAME = 'person',
    AMOUNTNAME = 'amount',
    REASONNAME = 'reason';

  final int id;
  final double amount;
  final String toPersonID;
  final String reason;

  Debt({this.id, this.toPersonID, this.amount, this.reason});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'person': toPersonID,
      'amount': amount,
      'reason': reason,
    };
  }
}