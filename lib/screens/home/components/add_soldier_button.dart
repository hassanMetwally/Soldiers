// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/soldier.dart';
import '../../../size_config.dart';


class AddSoldierButton extends StatelessWidget {
  AddSoldierButton({
    required this.restSoldiersList,
    required this.updateSugListFunc,

    super.key,
  });

  List<Soldier>? restSoldiersList;
  final Function(Soldier) updateSugListFunc;

  Color backgroundColor = kPrimaryLightColor;
  Color iconColor = kSecondaryColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       // buildShowDialog(context, restSoldiersList , updateSugListFunc);
        showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState){
                  return  AlertDialog(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    scrollable: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(62.0)),
                    content: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            ...List.generate(restSoldiersList!.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState((){
                                    restSoldiersList!.remove(restSoldiersList![index]);
                                    updateSugListFunc(restSoldiersList![index]);
                                  });
                                },
                                child: Container(
                                    width: getProportionateScreenWidth(240),
                                    padding: EdgeInsets.symmetric(horizontal: 18),
                                    margin:
                                    EdgeInsets.symmetric(vertical: 5, horizontal: 0),
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          restSoldiersList![index].name,
                                          //style: TextStyle(fontSize: 22),
                                        ),
                                        Text(restSoldiersList![index].returnDate.toString()),
                                      ],
                                    )),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  );
                },

              );
            });
      },
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            border: Border.all(color: Colors.white, width: 5)),
        child: Icon(Icons.add, color: iconColor, size: 29),
      ),
    );
  }
}
//
// Future<dynamic> buildShowDialog(BuildContext context, List<Soldier>? restSoldiersList, Function updateSugListFunc) {
//
//
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState){
//             return  AlertDialog(
//               contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//               scrollable: true,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(62.0)),
//               content: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: kPrimaryLightColor,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(0),
//                   child: Column(
//                     children: [
//                       ...List.generate(restSoldiersList!.length, (index) {
//                         return GestureDetector(
//                           onTap: () {
//                             setState((){
//                               restSoldiersList.remove(restSoldiersList[index]);
//                               updateSugListFunc(restSoldiersList[index]);
//                             });
//                           },
//                           child: Container(
//                               width: getProportionateScreenWidth(240),
//                               padding: EdgeInsets.symmetric(horizontal: 18),
//                               margin:
//                               EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(5),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       offset: Offset(0, 4),
//                                       blurRadius: 10,
//                                       color: Color(0xFFB0CCE1).withOpacity(.32))
//                                 ],
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     restSoldiersList[index].name,
//                                     //style: TextStyle(fontSize: 22),
//                                   ),
//                                   Text(restSoldiersList[index].returnDate.toString()),
//                                 ],
//                               )),
//                         );
//                       })
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//
//         );
//       });
// }
