import 'package:debtdiary/Debt.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHandler {
  static const String TABLENAME = 'debts';

  final Future<Database> _database;

  DataBaseHandler() : _database = _openDataBase();

  static Future<Database> _openDataBase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'debt_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $TABLENAME(${Debt.IDNAME} INTEGER PRIMARY KEY, ${Debt.PERSONNAME} TEXT, ${Debt.AMOUNTNAME} REAL, ${Debt.REASONNAME} TEXT)",
          ).catchError((error) {
            print("[!!] in OpenDataBase:DataBaseHandler");
            print((error as Error).stackTrace);
          });
      },
      version: 1,
    );
  }

  Future<void> insertDebt(Debt debt) async {
    final Database db = await _database;

    await db.insert(
      TABLENAME,
      debt.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Debt>> getAllDebts() async {
    final Database db = await _database;

    final List<Map<String, dynamic>> list = await db.query(TABLENAME);

    return List.generate(list.length, (i) {
      return Debt(
        id: list[i][Debt.IDNAME],
        toPersonID: list[i][Debt.PERSONNAME],
        amount: list[i][Debt.AMOUNTNAME],
        reason: list[i][Debt.REASONNAME],
      );
    });
  }

  Future<void> clearDataBase() async {
    final Database db = await _database;

    return await db.rawDelete("DELETE FROM $TABLENAME").catchError((error) {
      print("[!!] in ClearDataBase:DataBaseHandler");
      print((error as Error).stackTrace);
    });
  }
}
