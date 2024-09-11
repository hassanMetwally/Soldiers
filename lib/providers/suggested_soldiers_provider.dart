import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../helpers/db_helper.dart';
import '../models/soldier.dart';

class SuggestedSoldiersProvider with ChangeNotifier {
  static int suggestionRatio = 4;

  final Map<int, List<Soldier>> _suggestedSoldiersList = {};

  Map<int, List<Soldier>> get suggestedSoldiersList {
    return {..._suggestedSoldiersList};
  }

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  fetchSuggestedSoldiers(int sectionId) async {
    final sectionSoldiersDataList = await _databaseHelper.getSoldiersBySection(sectionId);
    final existingSoldiersDataList = await _databaseHelper.getExistingSoldiersBySection(sectionId);
    final outingSoldiersDataList = await _databaseHelper.getOutingSoldiersBySection(sectionId);

    List<Soldier> sectionSoldiers = sectionSoldiersDataList.map((item) {
      return Soldier(
        id: item['id'],
        name: item['name'],
        sectionId: item['sectionId'],
        returnDate: item['returnDate'],
        attendance: item['attendance'],
      );
    }).toList();

    List<Soldier> existingSoldiers = existingSoldiersDataList.map((item) {
      return Soldier(
        id: item['id'],
        name: item['name'],
        sectionId: item['sectionId'],
        returnDate: item['returnDate'],
        attendance: item['attendance'],
      );
    }).toList();

    List<Soldier> outingSoldiers = outingSoldiersDataList.map((item) {
      return Soldier(
        id: item['id'],
        name: item['name'],
        sectionId: item['sectionId'],
        returnDate: item['returnDate'],
        attendance: item['attendance'],
      );
    }).toList();

    int suggestionsLength = (sectionSoldiers.length / suggestionRatio).round();


    if (outingSoldiers.length < suggestionsLength) {
      suggestionsLength = suggestionsLength - outingSoldiers.length;

      _suggestedSoldiersList[sectionId] = existingSoldiers.sublist(0, suggestionsLength);

      int presenceDuration = ((suggestionRatio - 1) * 6);
      String presenceDurationTime0 = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: presenceDuration)));
      DateTime presenceDurationTime = DateTime.parse(presenceDurationTime0);

      _suggestedSoldiersList[sectionId]!.removeWhere((soldier) => DateTime.parse(soldier.returnDate).isAfter(presenceDurationTime));

      notifyListeners();
    } else {
      _suggestedSoldiersList[sectionId] = [];
      notifyListeners();
    }
  }

  updateSoldier(Soldier soldier) async {
    await _databaseHelper.updateSoldiers(soldier);
    await fetchSuggestedSoldiers(soldier.sectionId);
  }

  removeSuggestion(Soldier soldier) async {
    _suggestedSoldiersList.remove(soldier);
    notifyListeners();
  }
}
