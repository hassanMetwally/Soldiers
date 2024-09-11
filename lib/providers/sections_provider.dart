
import 'package:flutter/material.dart';

import '../helpers/db_helper.dart';
import '../models/section.dart';


class SectionsProvider with ChangeNotifier {

  List<Section> _sections = [];

  List<Section> get sections {
    return [..._sections];
  }

 final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> addSection(String name)async{
    final section = Section(name: name);
    await _databaseHelper.insertSection(section);
    await fetchSections();
  }

  Future<void> deleteSection(int id) async {
    await _databaseHelper.deleteSection(id);
    await fetchSections();
  }
  
  Future<void> fetchSections()async{
    final dataList = await _databaseHelper.getSections();
      _sections = dataList.map((item) => Section(id: item['id'],name: item['name']) ).toList();
      notifyListeners();

  }
}
