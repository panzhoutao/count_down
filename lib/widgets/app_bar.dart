import 'package:count_down/style/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.rightWidget,
    this.title,
    this.leftWidget,
  });

  ///
  final Widget? leftWidget;

  ///
  final Widget? rightWidget;

  ///
  final String? title;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, 64.w);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.w),
          topRight: Radius.circular(24.w),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        color: MyThemeData.instance.backgroundColor,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: widget.leftWidget ??
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      foregroundColor: Color(0xFF000000).withOpacity(0.5),
                      textStyle: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('取消'),
                  ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: widget.rightWidget ?? Container(),
            ),
            if (widget.title != null)
              Align(
                alignment: Alignment.center,
                child: Text(
                  '${widget.title}',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
