import 'package:baganbilash/Views/app_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp((ScreenUtilInit(
      designSize: Size(375, 725),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        );
      })));
}
