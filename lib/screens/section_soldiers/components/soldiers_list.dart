// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../models/section.dart';
import '../../../models/soldier.dart';
import '../../../providers/sections_provider.dart';
import '../../../providers/soldiers_provider.dart';
import '../../../size_config.dart';

class SoldiersList extends StatelessWidget {
  SoldiersList({
    required this.sectionSoldiersList,
    Key? key,
  }) : super(key: key);
  List<Soldier>? sectionSoldiersList;
  @override
  Widget build(BuildContext context) {

    Map<int?,String> sections ={};
    Provider.of<SectionsProvider>(context, listen: false).fetchSections();
    List<Section> sectionsList = Provider.of<SectionsProvider>(context, listen: false).sections;
    for(Section section in sectionsList){
      sections[section.id] = section.name;
    }

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 50,top:20 ),
      width: getProportionateScreenWidth(170),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kPrimaryLightColor,
      ),
      child: Column(
        children: [
          ...List.generate(
            sectionSoldiersList!.length,
            (index) => GestureDetector(
              onTap: () {},
              child: Container(
                width: getProportionateScreenWidth(150),
                padding: EdgeInsets.only(left: 0, right: 20, top: 5, bottom: 5),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 20,
                        color: Color(0xFFB0CCE1).withOpacity(.32))
                  ],
                ),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(sectionSoldiersList![index].name),
                        Text(sectionSoldiersList![index].returnDate.toString()),
                      ],
                    ),
                    Spacer(),
                    Text(sections[sectionSoldiersList![index].sectionId].toString()),
                    SizedBox(width: getProportionateScreenWidth(10),),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          color: sectionSoldiersList![index].attendance == 1
                              ? Colors.green
                              : Colors.red,
                          shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(3),
                    ),
                    IconButton(
                      onPressed: () async{
                        await buildShowDialog(context, sectionSoldiersList![index]);
                      },
                      tooltip: 'تحديث عودة الجندى',
                      icon: Icon(
                        Icons.edit,
                        color: kTextColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<SoldiersProvider>(context, listen: false).deleteSoldier(sectionSoldiersList![index]);
                        sectionSoldiersList!.removeAt(index);
                      },
                      tooltip: 'حذف الجندى',
                      icon: Icon(
                        Icons.delete,
                        color: kTextColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context,Soldier soldier) {
    final _formKey = GlobalKey<FormState>();
    String? returnDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String? todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          content: Container(
            width: getProportionateScreenWidth(150),
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  StatefulBuilder(builder: (context, StateSetter setState) {
                    return Row(
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
                            _formKey.currentState!.save();
                            soldier.returnDate = returnDate!;

                            DateTime dateTime1 = DateTime.parse(returnDate!);
                            DateTime dateTime2 = DateTime.parse(todayDate);
                            if(dateTime1.isBefore(dateTime2) || dateTime1.isAtSameMomentAs(dateTime2)){
                              soldier.attendance = 1;
                            }else{
                              soldier.attendance = 0;
                            }
                           // soldier.attendance = 0;
                            Provider.of<SoldiersProvider>(context, listen: false).updateSoldier(soldier);
                            Navigator.pop(context);
                          }
                        },
                        child: Text('تحديث'),
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
