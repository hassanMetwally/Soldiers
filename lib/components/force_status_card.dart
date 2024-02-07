// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class ForceStatusCard extends StatelessWidget {
   ForceStatusCard({
     required this.force,
     required this.exist,
     required this.out,
     super.key,
  });

   int? force;
   int exist;
   int out;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      margin: EdgeInsets.only(top: 20, right: 20,left: 20),
      width: getProportionateScreenWidth(170),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kSecondaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("القوة",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18,)),

                    Text(force.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16,),),
                  ],
                ),
                Column(
                  children: [
                    Text("الموجود",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18,),),

                    Text(exist.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16,),),
                  ],
                ),
                Column(
                  children: [
                    Text("الخارج",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18,),),

                    Text(out.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16,),),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
