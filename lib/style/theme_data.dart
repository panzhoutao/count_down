import 'package:flutter/material.dart';

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
  static const primaryColor = Color(0xFF698DF1);

  ///
  static const backgroundColor = Color(0xFFF2F2F5);

  ///
  ThemeData get themeData => ThemeData(
        // colorScheme: ColorScheme(
        //   brightness: brightness,
        //   primary: primary,
        //   onPrimary: onPrimary,
        //   secondary: secondary,
        //   onSecondary: onSecondary,
        //   error: error,
        //   onError: onError,
        //   background: background,
        //   onBackground: onBackground,
        //   surface: surface,
        //   onSurface: onSurface,
        // ),
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: primaryColor,
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
