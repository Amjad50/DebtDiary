import 'dart:ui';

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
        return db
            .execute(
          "CREATE TABLE $TABLENAME(${Debt.ID_SQL_NAME} INTEGER PRIMARY KEY, ${Debt.PERSON_SQL_NAME} TEXT, ${Debt.AMOUNT_SQL_NAME} REAL, ${Debt.REASON_SQL_NAME} TEXT, ${Debt.TIME_SQL_NAME} TEXT)",
        )
            .catchError((error) {
          print("[!!] in OpenDataBase:DataBaseHandler");
          print((error as Error).stackTrace);
        });
      },
      version: 1,
    );
  }

  Future<void> insertDebt(Debt debt) async {
    final Database db = await _database;

    await db
        .insert(
      TABLENAME,
      debt.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .catchError((error) {
      print("[!!] in insertDebt:DataBaseHandler");
      print((error as Error).stackTrace);
    });
  }

  Future<List<Debt>> getAllDebts() async {
    final Database db = await _database;

    final List<Map<String, dynamic>> list = await db.query(TABLENAME);

    return List.generate(list.length, (i) {
      return Debt(
          id: list[i][Debt.ID_SQL_NAME],
          toPersonID: list[i][Debt.PERSON_SQL_NAME],
          amount: list[i][Debt.AMOUNT_SQL_NAME],
          reason: list[i][Debt.REASON_SQL_NAME],
          time: list[i][Debt.TIME_SQL_NAME]);
    });
  }

  Future<void> clearDataBase() async {
    final Database db = await _database;

    return await db.rawDelete("DELETE FROM $TABLENAME").catchError((error) {
      print("[!!] in ClearDataBase:DataBaseHandler");
      print((error as Error).stackTrace);
    });
  }

  Future<bool> deleteDebt(Debt debt) async {
    final Database db = await _database;

    return await db
        .delete(TABLENAME, where: "id=?", whereArgs: [debt.id]).then((e) {
      return e == 1;
    });
  }
}
