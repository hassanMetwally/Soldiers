// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, must_be_immutable


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../components/drawer.dart';
import '../../components/force_status_card.dart';
import '../../models/soldier.dart';
import '../../providers/unit_soldiers_provider.dart';
import 'components/soldiers_list.dart';


class UnitSoldiersScreen extends StatelessWidget {
  UnitSoldiersScreen({Key? key}) : super(key: key);
  static String routeName = '/unitSoldersScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerWidget(
              refresh: null,
              selectedScreen: DrawerOptions.unitSoldiers,
            ),
            Expanded(
              child: FutureBuilder(
                future: Provider.of<UnitSoldiersProvider>(context, listen: false).fetchUnitSoldiers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for data
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Display an error message if an error occurred
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    // Display the fetched data
                    List<Soldier>? unitSoldiersList = Provider.of<UnitSoldiersProvider>(context).unitSoldiersList;
                    Map<String, int> forceStatus = Provider.of<UnitSoldiersProvider>(context, listen: false).unitForceStatus();
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ForceStatusCard(
                              force: forceStatus['force']!,
                              exist: forceStatus['exist']!,
                              out: forceStatus['out']!,),
                          SoldiersList(
                            soldiersList: unitSoldiersList,
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
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     buildShowDialog(context);
        //   },
        //   tooltip: 'إضافة جندى',
        //   child: Icon(Icons.add),
        // ),
    );
  }

}
