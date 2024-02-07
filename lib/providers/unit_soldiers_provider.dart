// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import '../models/soldier.dart';

class UnitSoldiersProvider with ChangeNotifier {
  List<Soldier> _unitSoldiersList = [];

  List<Soldier> get unitSoldiersList {
    return [..._unitSoldiersList];
  }


  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // addSoldier(String name, int sectionId, String returnDate, int attendance) async {
  //   Soldier soldier = Soldier(
  //     name: name,
  //     sectionId: sectionId,
  //     returnDate: returnDate,
  //     attendance: attendance,
  //   );
  //
  //   _sectionSoldiersList.add(soldier);
  //   await _databaseHelper.insertSoldier(soldier);
  //   await fetchUnitSoldiers();
  // }

  Future<void> fetchUnitSoldiers() async {
    final dataList = await _databaseHelper.getUnitSoldiers();
    _unitSoldiersList = dataList.map((item) {
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
    await fetchUnitSoldiers();
  }

  Future<void> deleteSoldier(Soldier soldier) async {
    await _databaseHelper.deleteSoldiers(soldier.id!);
    await fetchUnitSoldiers();
    //print(soldier.attendance);
  }
  Map<String, int> unitForceStatus() {
    int force = _unitSoldiersList.length ;
    int exist = 0;
    int out = 0;
    for (Soldier soldier in _unitSoldiersList) {
      if (soldier.attendance == 1) {
        exist += 1;
      } else {
        out += 1;
      }
    }
    return {'force': force, 'exist': exist, 'out': out};

  }
}
