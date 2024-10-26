import 'package:count_down/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';

///
class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key});

  Widget _buildHeader() {
    return Container(
      height: 54.w,
      width: 54.w,
      child: Placeholder(),
    );
  }

  ///
  Widget _buildTitle() {
    return Text(
      'title',
      style: TextStyle(
        fontSize: 16.sp,
      ),
    );
  }

  ///
  Widget _buildDate() {
    return Text(
      '2000-01-01',
      style: TextStyle(
        fontSize: 13.sp,
        color: Colors.grey,
      ),
    );
  }

  ///
  Widget _buildRemaining() {
    return Text(
      '0',
      style: TextStyle(
        fontSize: 44.sp,
      ),
    );
  }

  ///
  Widget _buildTrailing() {
    return Container(
      width: 33.w,
      height: double.infinity,
      color: Colors.black,
      alignment: Alignment.center,
      child: Text(
        '天',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                _buildHeader(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTitle(),
                      SizedBox(height: 5.w),
                      _buildDate(),
                    ],
                  ),
                ).expand(),
                _buildRemaining(),
              ],
            ),
          ).expand(),
          _buildTrailing(),
        ],
      ),
    );
  }
}
