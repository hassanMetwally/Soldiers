// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/section.dart';
import '../../../providers/sections_provider.dart';
import '../../../size_config.dart';
import '../../section_soldiers/section_soldiers_screen.dart';

class SectionsList extends StatelessWidget {
  SectionsList({required this.sectionsList, Key? key}) : super(key: key);
  List<Section>? sectionsList;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 50),
        width: getProportionateScreenWidth(170),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kPrimaryLightColor,
        ),
        child: Column(
          children: [
            ...List.generate(
              sectionsList!.length,
              (index) => Tooltip(
                message: 'ضغطة طويلة لحذف القسم',
                child: GestureDetector(
                  onLongPress: () {
                    buildShowDialog(context,index);
                  },
                  onTap: () {
                    Navigator.pushNamed(context, SectionSoldiersScreen.routeName,
                        arguments: sectionsList![index].id);
                  },
                  child: Container(
                    width: getProportionateScreenWidth(150),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 10,
                            color: Color(0xFFB0CCE1).withOpacity(.32))
                      ],
                    ),
                    child: Center(
                      child: Text(
                        sectionsList![index].name.toString(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
  Future<dynamic> buildShowDialog(BuildContext context, int index) {

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          title: Text('هل انت متأكد'),
          content: Text('هل انت متأكد من مسح القسم؟'),
          actions: [
            TextButton(child: Text("لا"),onPressed: (){
              Navigator.of(context).pop(false);
            },),
            TextButton(child: Text("نعم"),onPressed: (){
              Provider.of<SectionsProvider>(context,listen: false).deleteSection(sectionsList![index].id!);
              sectionsList!.removeAt(index);
              Navigator.of(context).pop(true);
            },),
          ],
        );
      },
    );
  }

}
