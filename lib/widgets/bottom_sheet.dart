import 'package:count_down/style/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';

///
class BottomSheetWidget extends StatefulWidget {
  ///
  const BottomSheetWidget({
    super.key,
    required this.title,
    required this.child,
    required this.onConfirm,
  });

  ///
  final String title;

  ///
  final Widget child;

  ///
  final Function() onConfirm;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  ///
  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.w),
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: 20.sp,
        ),
      ),
    );
  }

  ///
  Widget _buildContent() {
    return widget.child;
  }

  ///
  Widget _buildBottom() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 17.w),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: 18.sp),
              backgroundColor: Color(0xFFD8D8D8),
              foregroundColor: Color(0xFF919191),
              padding: EdgeInsets.symmetric(vertical: 15.w),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('取消'),
          ).expand(),
          SizedBox(width: 43.w),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: 18.sp),
              padding: EdgeInsets.symmetric(vertical: 15.w),
            ),
            onPressed: () {
              widget.onConfirm();
            },
            child: Text('确定'),
          ).expand(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyThemeData.instance.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          Divider(
            thickness: 1,
            height: 1,
            color: Colors.white,
          ),
          _buildContent(),
          _buildBottom(),
        ],
      ),
    );
  }
}
