import 'package:baganbilash/Controllers/style_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget dieaseName(String diseaseName, void Function()? routname) {
  return GestureDetector(
      onTap: routname,
      child: Container(
        height: ScreenUtil().setHeight(60),
        width: ScreenUtil().setWidth(220),
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Color(0xFFE99600),
        ),
        child: Text(
          diseaseName,
          textAlign: TextAlign.center,
          style: myStyle18(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ));
}
