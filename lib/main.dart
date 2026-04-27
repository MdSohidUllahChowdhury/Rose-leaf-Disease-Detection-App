import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rose_leaf_ai/prediction_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    (ScreenUtilInit(
      designSize: Size(375, 725),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          home: PredictionScreen(),
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[900],
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey[900],
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            primarySwatch: Colors.blue,
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    )),
  );
}
