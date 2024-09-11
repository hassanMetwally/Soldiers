// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../providers/suggested_soldiers_provider.dart';
import '../screens/about/about_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/sections/sections_screen.dart';
import '../screens/unit_soldiers/unit_soldiers_screen.dart';
import '../size_config.dart';

enum DrawerOptions { vacations, sections, unitSoldiers, about, settings, no }

class DrawerWidget extends StatelessWidget {
  DrawerWidget({required this.refresh, required this.selectedScreen});

  DrawerOptions selectedScreen;
  Function? refresh;

  static int selectedOption = 4;

  List<int> options = <int>[2, 3, 4, 5, 6];

  SharedPreferences? prefs;

  saveData(suggestionRatio) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setInt("suggestionRatio", suggestionRatio);
  }

  getData() async {
    prefs = await SharedPreferences.getInstance();
    selectedOption == prefs!.getInt("suggestionRatio");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Center(
                child: Image.asset(
              'assets/images/egypt.png',
              fit: BoxFit.cover,
              width: 250,
              height: 250,
            )),
          ),
          Spacer(flex: 2),
          ListTile(
            title: Text(
              'تحديث النتــــــــــــــــائج',
              style: TextStyle(),
            ),
            onTap: () {
              refresh!();
            },
            leading: Icon(Icons.refresh, color: Colors.black),
            minLeadingWidth: 50,
          ),
          Divider(
            endIndent: 10,
            indent: 10,
          ),
          ListTile(
            title: Text(
              'الأجــــــــــــــــــــــــــــــازات',
              style: TextStyle(
                color: selectedScreen == DrawerOptions.vacations
                    ? kSecondaryColor
                    : Colors.black,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
            leading: Icon(Icons.home,
                color: selectedScreen == DrawerOptions.vacations
                    ? kSecondaryColor
                    : Colors.black),
            minLeadingWidth: 50,
          ),
          Divider(
            endIndent: 10,
            indent: 10,
          ),
          ListTile(
            title: Text(
              'أقسام الوحــــــــــــــــدة',
              style: TextStyle(
                color: selectedScreen == DrawerOptions.sections
                    ? kSecondaryColor
                    : Colors.black,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, SectionsScreen.routeName);
            },
            leading: Icon(
              Icons.menu,
              color: selectedScreen == DrawerOptions.sections
                  ? kSecondaryColor
                  : Colors.black,
            ),
            minLeadingWidth: 50,
          ),
          Divider(
            endIndent: 10,
            indent: 10,
          ),
          ListTile(
            title: Text(
              'قوة الوحــــــــــــــــــــــدة',
              style: TextStyle(
                color: selectedScreen == DrawerOptions.unitSoldiers
                    ? kSecondaryColor
                    : Colors.black,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, UnitSoldiersScreen.routeName);
            },
            leading: Icon(
              Icons.local_fire_department,
              color: selectedScreen == DrawerOptions.unitSoldiers
                  ? kSecondaryColor
                  : Colors.black,
            ),
            minLeadingWidth: 50,
          ),
          Divider(
            endIndent: 10,
            indent: 10,
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return ListTile(
                title: Text(
                  'عدد الدفعـــــــــــــــــات',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () async {
                  getData();
                  int? suggestionRatio = await showMaterialScrollPicker(
                    showDivider: false,
                    context: context,
                    title: "عدد الدفعات",
                    items: options,
                    selectedItem: selectedOption,
                    onChanged: (value) {
                      selectedOption = value;
                      setState(() {
                        saveData(value);
                      });
                    },
                  );
                  SuggestedSoldiersProvider.suggestionRatio = suggestionRatio!;
                },
                leading: Icon(Icons.people, color: Colors.black),
                minLeadingWidth: 50,
              );
            },
          ),
          Spacer(flex: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(Icons.info,size: 16,color: selectedScreen == DrawerOptions.about
                    ? kSecondaryColor
                    : Colors.black,),
                  onPressed: () {
                    Navigator.pushNamed(context, AboutScreen.routeName);
                  },
                  label: Text(
                    'about',
                    style: TextStyle(
                        color: selectedScreen == DrawerOptions.about
                            ? kSecondaryColor
                            : Colors.black,
                        fontSize: 13),
                  )),
              SizedBox(
                width: getProportionateScreenWidth(5),
              ),
            ],
          )
        ],
      ),
    );
  }
}
