import 'package:count_down/pages/settings/sort_and_tag/sort_and_tag.dart';
import 'package:count_down/style/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';

///
class ClosePage extends StatelessWidget {
  const ClosePage({
    super.key,
    this.onClose,
    required this.child,
  });

  ///
  final Widget child;

  ///
  final Function()? onClose;

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
      child: Stack(
        children: [
          child,
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                onClose?.call();
                Navigator.of(context).pop();
              },
              child: Container(
                width: 54.w,
                height: 54.w,
                alignment: Alignment.center,
                child: Icon(
                  Icons.cancel,
                  size: 26.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
class AddPage extends StatelessWidget {
  const AddPage({
    super.key,
    this.onAdd,
    required this.child,
  });

  ///
  final Widget child;

  ///
  final Function()? onAdd;

  ///
  Widget _buildTitle(BuildContext context) {
    return Container(
      height: 64.w,
      color: MyThemeData.instance.backgroundColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                '取消',
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                onAdd?.call();
              },
              child: ElevatedButton(
                onPressed: () {},
                child: Text('添加'),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
      child: Column(
        children: [
          _buildTitle(context),
          child.expand(),
        ],
      ),
    );
  }
}
