// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:soldiers/screens/home/components/section_force_status.dart';

import '../../../constants.dart';
import '../../../models/section.dart';
import '../../../models/soldier.dart';
import '../../../providers/soldiers_provider.dart';
import '../../../providers/suggested_soldiers_provider.dart';
import '../../../size_config.dart';
import '../../section_soldiers/section_soldiers_screen.dart';
import 'accept_button.dart';

class SuggestionsCard extends StatefulWidget {
  SuggestionsCard({
    required this.section,
    super.key,
  });

  Section section;

  @override
  State<SuggestionsCard> createState() => _SuggestionsCardState();
}

class _SuggestionsCardState extends State<SuggestionsCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SuggestedSoldiersProvider>(context, listen: false).fetchSuggestedSoldiers(widget.section.id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while waiting for data
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Display an error message if an error occurred
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Soldier>? sugSoldiersList = Provider.of<SuggestedSoldiersProvider>(context, listen: false).suggestedSoldiersList[widget.section.id!];
          Provider.of<SoldiersProvider>(context, listen: false).fetchSoldiersBySections(widget.section.id!);
          Map<String, int> forceStatus = Provider.of<SoldiersProvider>(context, listen: false).sectionForceStatus(widget.section.id!);
          // List<Soldier>? restSoldiersList = Provider.of<SuggestedSoldiersProvider>(context, listen: false).restSoldiersList[widget.section.id];
          // void updateSugList(Soldier soldier) {1
          //   setState(() {
          //     sugSoldiersList!.add(soldier);
          //     //print(sugSoldiersList.length);
          //   });
          // }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: getProportionateScreenWidth(170),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryLightColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 23),
                    child: Column(
                      children: [
                        SectionForceStatusWidget(forceStatus: forceStatus),
                        ...List.generate(sugSoldiersList!.length, (index) {
                          return Dismissible(
                            key: Key(index.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 5),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFFE6E6),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Spacer(),
                                  SvgPicture.asset('assets/icons/Trash.svg'),
                                ],
                              ),
                            ),
                            onDismissed: (direction) {
                              sugSoldiersList.removeAt(index);
                            },
                            child: Container(
                                width: getProportionateScreenWidth(140),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 5),
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 10,
                                      color: Color(0xFFB0CCE1).withOpacity(.32),
                                    )
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sugSoldiersList[index].name,
                                      //style: TextStyle(fontSize: 22),
                                    ),
                                    Text(sugSoldiersList[index]
                                        .returnDate
                                        .toString()),
                                  ],
                                )),
                          );
                        }),
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -5,
                  left: getProportionateScreenWidth(45),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, SectionSoldiersScreen.routeName,
                          arguments: widget.section.id);
                    },
                    child: Container(
                      width: getProportionateScreenWidth(90),
                      height: getProportionateScreenWidth(13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 5),
                        color: kPrimaryLightColor,
                      ),
                      child: Center(
                          child: Text(widget.section.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -2,
                  left: -2,
                  child: AcceptButton(
                    sugSoldiersList: sugSoldiersList,
                  ),
                ),

                // Positioned(
                //   bottom: -2,
                //   left: 60,
                //   child: AddSoldierButton(
                //     restSoldiersList: restSoldiersList,
                //     updateSugListFunc: updateSugList,
                //   ),
                // ),
              ],
            ),
          );
        }
      },
    );
  }
}
