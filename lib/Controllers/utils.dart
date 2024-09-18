import 'package:baganbilash/Views/homePage.dart';
import 'package:flutter/material.dart';

Widget DieaseName (String diseaseName,void Function()? routname ){


   return GestureDetector(
            onTap:routname,
            child: Container(
                padding: const EdgeInsets.only(left: 30),
                child: ListTile(
                  title: Text(
                    diseaseName,
                    style: myStile25(
                        color: Colors.black, 
                        fontWeight: FontWeight.bold),
                  ),
                  tileColor: Color(0xFFE99600),
                )),
          );
}