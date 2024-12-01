import 'package:count_down/entities/countdown_entity.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';
import 'package:get/get.dart';

// ///
// class HomeCountdownWidget extends StatefulWidget {
//   const HomeCountdownWidget({super.key});
//
//   @override
//   State<HomeCountdownWidget> createState() => _HomeCountdownWidgetState();
// }
//
// class _HomeCountdownWidgetState extends State<HomeCountdownWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       builder: (controller) {
//         return ;
//       },
//     );
//   }
// }

///
class HomeCountdownItemWidget extends StatelessWidget {
  const HomeCountdownItemWidget({super.key, required this.data});

  final DbCountdownEntity data;

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
      data.name!,
      style: TextStyle(
        fontSize: 16.sp,
      ),
    );
  }

  ///
  Widget _buildDate() {
    String dateText = formatDate(
      DateTime.parse(data.dateTime!),
      [yyyy, '-', mm, '-', dd],
    );
    return Text(
      dateText,
      style: TextStyle(
        fontSize: 13.sp,
        color: Colors.grey,
      ),
    );
  }

  ///
  Widget _buildTip() {
    return Text(
      data.tipText ?? '',
      style: TextStyle(
        fontSize: 16.sp,
      ),
    );
  }

  ///
  Widget _buildRemaining() {
    return Text(
      '${data.differenceDays == 0 ? '今天' : data.differenceDays}',
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
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
                _buildTip(),
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
