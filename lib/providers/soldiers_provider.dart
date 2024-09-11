// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/soldier.dart';

class SoldiersProvider with ChangeNotifier {
  Map<int, List<Soldier>> _sectionSoldiersList = {};

  Map<int, List<Soldier>> get sectionSoldiersList {
    return {..._sectionSoldiersList};
  }


  final DatabaseHelper _databaseHelper = DatabaseHelper();

  addSoldier(String name, int sectionId, String returnDate, int attendance) async {
    Soldier soldier = Soldier(
      name: name,
      sectionId: sectionId,
      returnDate: returnDate,
      attendance: attendance,
    );

    _sectionSoldiersList[sectionId]!.add(soldier);
    await _databaseHelper.insertSoldier(soldier);
    await fetchSoldiersBySections(sectionId);
  }

  Future<void> fetchSoldiersBySections(int sectionId) async {
    final dataList = await _databaseHelper.getSoldiersBySection(sectionId);
    _sectionSoldiersList[sectionId] = dataList.map((item) {
      return Soldier(
        id:  item['id'],
        name: item['name'],
        sectionId: item['sectionId'],
        returnDate: item['returnDate'],
        attendance: item['attendance'],
      );
    }).toList();
    notifyListeners();
  }

  Future<void> updateSoldier(Soldier soldier) async {
    await _databaseHelper.updateSoldiers(soldier);
    await fetchSoldiersBySections(soldier.sectionId);
  }

  Future<void> deleteSoldier(Soldier soldier) async {
    await _databaseHelper.deleteSoldiers(soldier.id!);
    await fetchSoldiersBySections(soldier.sectionId);
    //print(soldier.attendance);
  }


  Map<String, int> sectionForceStatus(int sectionId) {
    int force = sectionSoldiersList[sectionId]!.length ;
    int exist = 0;
    int out = 0;
    for (Soldier soldier in sectionSoldiersList[sectionId]!) {
      if (soldier.attendance == 1) {
        exist += 1;
      } else {
        out += 1;
      }
    }
    return {'force': force, 'exist': exist, 'out': out};

  }



}
