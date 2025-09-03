import 'package:roseleaf/utils/styleFonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget dieaseName(String diseaseName, void Function()? routname) {
  return GestureDetector(
      onTap: routname,
      child: Container(
        height: ScreenUtil().setHeight(40),
        width: ScreenUtil().setWidth(220),
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Text(
          diseaseName,
          textAlign: TextAlign.center,
          style: fontLarg(color: Color(0xFF004643,)),
        ),
      ));
}
