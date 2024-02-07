// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/drawer.dart';
import '../../constants.dart';
import '../../models/section.dart';
import '../../providers/sections_provider.dart';
import '../../size_config.dart';
import '../home/home_screen.dart';
import 'components/sections_list.dart';

class SectionsScreen extends StatelessWidget {
  SectionsScreen({Key? key}) : super(key: key);
  static String routeName = '/Sections';

  late String sectionName;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        return false;
      },
      child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerWidget(
              refresh: null,
              selectedScreen: DrawerOptions.sections,
            ),
            Expanded(
              child: FutureBuilder(
                  future: Provider.of<SectionsProvider>(context, listen: false).fetchSections(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Display a loading indicator while waiting for data
                      return Container(
                          color: Colors.white,
                          child: Center(child: CircularProgressIndicator()));
                    } else if (snapshot.hasError) {
                      // Display an error message if an error occurred
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      // Display the fetched data
                      List<Section> sectionsList = Provider.of<SectionsProvider>(context).sections;
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 10),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                width: getProportionateScreenWidth(170),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kSecondaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                        child: Text(
                                      'أقسام الوحــــــــــــــــدة',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              SectionsList(
                                sectionsList: sectionsList,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            buildShowDialog(context);
          },
          tooltip: 'إضافة قسم',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Center(child: const Text("إضافة قسم")),
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
                      hintText: 'إسم القســــــــــــــــــــــــم',
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
                        return 'ادخل إسم السلاح';
                      }
                      return null;
                    },
                    onSaved: (newValue) => sectionName = newValue!,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: SizedBox(
                      width: SizeConfig.screenWidth,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Provider.of<SectionsProvider>(context,
                                    listen: false)
                                .addSection(sectionName);
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
