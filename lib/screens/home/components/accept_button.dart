// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../models/soldier.dart';
import '../../../providers/soldiers_provider.dart';


class AcceptButton extends StatefulWidget {
  AcceptButton({
    required this.sugSoldiersList,
    super.key,
  });
  List<Soldier>? sugSoldiersList;
  @override
  State<AcceptButton> createState() => _AcceptButtonState();
}

class _AcceptButtonState extends State<AcceptButton> {
  bool state = false;
  late Color backgroundColor;
  late Color iconColor;
  late String returnDate;

  @override
  Widget build(BuildContext context) {
    if (state) {
      backgroundColor = HexColor('18feaf');
      iconColor = Colors.white;
    } else {
      backgroundColor = kPrimaryLightColor;
      iconColor = kSecondaryColor;
    }
    return Tooltip(
      message: 'إمضاء اجازة',
      child: GestureDetector(
        onTap: () async {
          if (state) {
            return;
          }
          DateTime? _returnDate = await showDatePicker(
            context: context,
             initialDate: DateTime.now(),
            firstDate: DateTime(2015, 8),
             lastDate: DateTime(2101),
           );
           if (state == true && _returnDate != null) {
             return;
           }
          returnDate = DateFormat('yyyy-MM-dd').format(_returnDate!);
           for (Soldier soldier in widget.sugSoldiersList!) {
            //soldier.id = widget.sugSoldiersList![1].id;
            soldier.attendance = 0;
            soldier.returnDate = returnDate;
            Provider.of<SoldiersProvider>(context, listen: false).updateSoldier(soldier);
          }
          setState(() {
            state = !state;
          });

        },

        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              border: Border.all(color: Colors.white, width: 5)),
          child: Icon(Icons.check_rounded, color: iconColor, size: 29),
        ),
      ),
    );
  }
}
