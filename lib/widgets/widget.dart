import 'package:count_down/style/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
class WidgetExtends {
  ///
  static PreferredSizeWidget appBar({
    String? title,
  }) {
    return AppBar(
      centerTitle: true,
      backgroundColor: MyThemeData.instance.backgroundColor,
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Container(),
    );
  }
}
