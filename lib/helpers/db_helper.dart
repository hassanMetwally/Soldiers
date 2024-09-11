import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:intl/intl.dart';

import '../models/section.dart';
import '../models/soldier.dart';

class DatabaseHelper {
  Future<sql.Database> _dataBase() async {
    final dbsPath = await sql.getDatabasesPath();
    final String path = join(dbsPath, 'soldiers.db');

    return sql.openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE sections_table(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE soldiers_table(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            sectionId INTEGER NOT NULL,
            returnDate TEXT,
            attendance BIT,
            FOREIGN KEY (sectionId) REFERENCES sections_table(id) ON DELETE CASCADE
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertSoldier(Soldier soldier) async {
    final db = await _dataBase();
    db.insert('soldiers_table', soldier.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getSoldiersBySection(int sectionId) async {
    final db = await _dataBase();
    List<Map<String, dynamic>> dataList = await db.query(
      'soldiers_table',
      where: 'sectionId = ?',
      whereArgs: [sectionId],
      orderBy: 'returnDate ASC',
    );
    await attendanceUpdate(dataList);

    return db.query(
      'soldiers_table',
      where: 'sectionId = ?',
      whereArgs: [sectionId],
      orderBy: 'returnDate ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getUnitSoldiers() async {
    final db = await _dataBase();
    List<Map<String, dynamic>> dataList = await db.query(
      'soldiers_table',
      orderBy: 'name ASC',
    );

    await attendanceUpdate(dataList);

    return db.query(
      'soldiers_table',
      orderBy: 'name ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getExistingSoldiersBySection(int sectionId) async {
    final db = await _dataBase();
    return db.query(
      'soldiers_table',
      where: 'sectionId = ? AND attendance = ?',
      whereArgs: [sectionId, 1],
      orderBy: 'returnDate ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getOutingSoldiersBySection(int sectionId) async {
    final db = await _dataBase();
    return db.query(
      'soldiers_table',
      where: 'sectionId = ? AND attendance = ?',
      whereArgs: [sectionId, 0],
      orderBy: 'returnDate ASC',
    );
  }

  Future<void> deleteSoldiers(int id) async {
    final db = await _dataBase();
    await db.delete('soldiers_table', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateSoldiers(Soldier soldier) async {
    final db = await _dataBase();
    await db.update(
      'soldiers_table',
      soldier.toMap(),
      where: 'id = ?',
      whereArgs: [soldier.id],
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<void> insertSection(Section section) async {
    final db = await _dataBase();
    db.insert('sections_table', section.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getSections() async {
    final db = await _dataBase();
    return await db.query(
      'sections_table',
    );
  }

  Future<void> deleteSection(int id) async {
    final db = await _dataBase();
    await db.delete('soldiers_table', where: 'sectionId = ?', whereArgs: [id]);
    await db.delete('sections_table', where: 'id = ?', whereArgs: [id]);
  }

  attendanceUpdate(List<Map<String, dynamic>> dataList) async{
    List<Soldier> soldiers = [];

    soldiers = dataList.map((item) {
      return Soldier(
        id: item['id'],
        name: item['name'],
        sectionId: item['sectionId'],
        returnDate: item['returnDate'],
        attendance: item['attendance'],
      );
    }).toList();

    for (var soldier in soldiers) {
      String todayDate0 = DateFormat('yyyy-MM-dd').format(DateTime.now());
      DateTime returnDate = DateTime.parse(soldier.returnDate);
      DateTime todayDate = DateTime.parse(todayDate0);
      if ((returnDate.isAtSameMomentAs(todayDate) && soldier.attendance == 0) ||
          (returnDate.isBefore(todayDate) && soldier.attendance == 0)) {
        soldier.attendance = 1;
        await updateSoldiers(soldier);
      }
    }
  }

}
