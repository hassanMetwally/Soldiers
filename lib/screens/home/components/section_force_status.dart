// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SectionForceStatusWidget extends StatelessWidget {
  const SectionForceStatusWidget({
    super.key,
    required this.forceStatus,
  });

  final Map<String, int> forceStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15,top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text('القوة'),
              SizedBox(height: 8,),
              Container(
                //padding: EdgeInsets.,
                width: getProportionateScreenWidth(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Center(
                    child: Text(
                        forceStatus['force']!.toString())),
              ),
            ],
          ),
          Column(
            children: [
              Text("الموجود"),
              SizedBox(height: 8,),
              Container(
                //padding: EdgeInsets.,
                width: getProportionateScreenWidth(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Center(
                    child: Text(
                        forceStatus['exist']!.toString())),
              ),
            ],
          ),
          Column(
            children: [
              Text("الخارج"),
              SizedBox(height: 8,),
              Container(
                //padding: EdgeInsets.,
                width: getProportionateScreenWidth(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Center(
                    child: Text(
                        forceStatus['out']!.toString())),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
