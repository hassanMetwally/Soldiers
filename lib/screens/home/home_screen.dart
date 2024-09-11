// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

//import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../components/drawer.dart';
import '../../components/force_status_card.dart';
import '../../providers/sections_provider.dart';
import '../../providers/suggested_soldiers_provider.dart';
import '../../providers/unit_soldiers_provider.dart';
import '../../size_config.dart';
import '../sections/sections_screen.dart';
import 'components/suggestions_card.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  Future<void> refresh() async {
    setState(() {});
  }
  SharedPreferences? prefs;

  getData() async {
    prefs = await SharedPreferences.getInstance();
    SuggestedSoldiersProvider.suggestionRatio = prefs!.getInt("suggestionRatio") ?? 4;
    DrawerWidget.selectedOption = prefs!.getInt("suggestionRatio") ?? 4;
  }

  @override
  Widget build(BuildContext context) {
    getData();
    SizeConfig.init(context);
    Future future1 = Provider.of<SectionsProvider>(context, listen: false).fetchSections();
    Future future2 = Provider.of<UnitSoldiersProvider>(context, listen: false).fetchUnitSoldiers();
    return RefreshIndicator(
      onRefresh: refresh,
      child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerWidget(
              refresh: refresh,
              selectedScreen: DrawerOptions.vacations,
            ),
            Expanded(
              child: FutureBuilder(
                future: Future.wait([future1, future2]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for data
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Display an error message if an error occurred
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    // Display the fetched data
                    final sectionsList = Provider.of<SectionsProvider>(context, listen: false).sections;
                    Provider.of<UnitSoldiersProvider>(context, listen: false).fetchUnitSoldiers();
                    Map<String, int> forceStatus = Provider.of<UnitSoldiersProvider>(context, listen: false).unitForceStatus();
                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ForceStatusCard(
                                force: forceStatus['force']!,
                                exist: forceStatus['exist']!,
                                out: forceStatus['out']!,
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              ...List.generate(sectionsList.length, (index) {
                                return SuggestionsCard(
                                  section: sectionsList[index],
                                );
                              }),
                              SizedBox(
                                height: getProportionateScreenHeight(55),
                              ),
                            ],
                          ),
                        ),
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
            Navigator.pushNamedAndRemoveUntil(
                context, SectionsScreen.routeName, (route) => route.isFirst);
          },
          tooltip: 'إضافة قسم',
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
