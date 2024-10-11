import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2021/12/12
class MyThemeData {
  static MyThemeData get instance => _getInstance();

  static MyThemeData? _instance;

  MyThemeData._internal();

  static MyThemeData _getInstance() {
    return _instance ??= MyThemeData._internal();
  }

  // ///primary padding
  // EdgeInsetsGeometry get primaryPadding =>
  //     EdgeInsets.symmetric(horizontal: 30.w);

  ///
  var seedColor = Color(0xFF3182F6);

  ///
  var primaryPadding = EdgeInsets.symmetric(horizontal: 28.w);

  ///
  ThemeData get themeData => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
        ),
        scaffoldBackgroundColor: Color(0xFFF3F8FF),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: seedColor,
          foregroundColor: Colors.white,
          shape: CircleBorder(),
        ),
      );

// ///
// AppBarTheme get _appBarTheme => AppBarTheme(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       centerTitle: true,
//       titleTextStyle: TextStyle(
//         color: Colors.black,
//         fontSize: 24.sp,
//         fontWeight: FontWeight.w400,
//       ),
//       toolbarHeight: 54.w,
//       iconTheme: const IconThemeData(color: Colors.black),
//     );
}
