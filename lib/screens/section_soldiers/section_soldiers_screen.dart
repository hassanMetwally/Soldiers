// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

import '../../components/drawer.dart';
import '../../components/force_status_card.dart';
import '../../constants.dart';
import '../../models/soldier.dart';
import '../../providers/soldiers_provider.dart';
import '../../size_config.dart';
import 'components/soldiers_list.dart';

class SectionSoldiersScreen extends StatelessWidget {
  SectionSoldiersScreen({Key? key}) : super(key: key);
  static String routeName = '/sectionSoldersScreen';
  String? id;
  String? name;
  String? returnDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  int? sectionId;
  int? attendance;

  @override
  Widget build(BuildContext context) {
    sectionId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerWidget(
              refresh: null,
              selectedScreen: DrawerOptions.no,
            ),
            Expanded(
              child: FutureBuilder(
                future: Provider.of<SoldiersProvider>(context, listen: false)
                    .fetchSoldiersBySections(sectionId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for data
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Display an error message if an error occurred
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    // Display the fetched data
                    List<Soldier>? sectionSoldiersList = Provider.of<SoldiersProvider>(context).sectionSoldiersList[sectionId];
                    Map<String, int> forceStatus = Provider.of<SoldiersProvider>(context, listen: false).sectionForceStatus(sectionId!);
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ForceStatusCard(
                              force: forceStatus['force']!,
                              exist: forceStatus['exist']!,
                              out: forceStatus['out']!),
                          SoldiersList(
                            sectionSoldiersList: sectionSoldiersList,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            buildShowDialog(context);
          },
          tooltip: 'إضافة جندى',
          child: Icon(Icons.add),
        ));
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Center(child: const Text("إضافة جندى")),
          content: Container(
            width: getProportionateScreenWidth(150),
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'الإسم',
                      filled: true,
                      fillColor: kPrimaryLightColor,
                      contentPadding:
                          const EdgeInsets.only(left: 14.0, right: 12),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kSecondaryColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    autofocus: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ادخل الإسم';
                      }
                      return null;
                    },
                    onSaved: (newValue) => name = newValue!,
                  ),
                  StatefulBuilder(builder: (context, StateSetter setState) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () async {
                                DateTime? _returnDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101),
                                );
                                setState(() {
                                  returnDate = DateFormat('yyyy-MM-dd').format(_returnDate!);
                                });
                              },
                              icon: Icon(Icons.date_range)),
                          Text(returnDate.toString())
                        ],
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: SizedBox(
                      width: SizeConfig.screenWidth,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a Snackbar.
                            //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                            _formKey.currentState!.save();

                            DateTime dateTime1 = DateTime.parse(returnDate!);
                            DateTime dateTime2 = DateTime.parse(todayDate);
                            if(dateTime1.isBefore(dateTime2) || dateTime1.isAtSameMomentAs(dateTime2)){
                              attendance = 1;
                            }else{
                              attendance = 0;
                            }
                            Provider.of<SoldiersProvider>(context, listen: false).addSoldier(
                              name!,
                              sectionId!,
                              returnDate!,
                              attendance!,
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Text('إدخال'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
