import 'package:count_down/entities/countdown_entity.dart';
import 'package:count_down/res/assets_res.dart';
import 'package:count_down/widgets/page.dart';
import 'package:count_down/widgets/scaffold.dart';
import 'package:date_format/date_format.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'logic.dart';

class SharePage extends StatefulWidget {
  const SharePage({
    super.key,
    required this.data,
  });

  ///
  final DbCountdownEntity data;

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  ///
  final logic = Get.put(ShareLogic());

  ///
  List<String> bgResList = [
    AssetsRes.SHARE_BG_1,
    AssetsRes.SHARE_BG_2,
    AssetsRes.SHARE_BG_3,
    AssetsRes.SHARE_BG_4,
    AssetsRes.SHARE_BG_5,
  ];

  ///
  int bgResIndex = 0;

  ///
  Widget _buildShare() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: Get.width / 4),
      child: ElevatedButton(
        onPressed: () {
          logic.saveImage();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15.w),
        ),
        child: Text('分享'),
      ),
    );
  }

  ///
  Widget _buildContent() {
    return Screenshot(
      controller: logic.screenshotController,
      child: _ContentWidget(
        data: widget.data,
        asset: bgResList[bgResIndex],
      ),
    ).paddingSymmetric(vertical: 20.w);
  }

  ///
  Widget _buildSelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '选择背景',
          style: TextStyle(fontSize: 12.sp, color: Color(0xFF575757)),
        ),
        SizedBox(height: 10.w),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 10.w,
          ),
          itemCount: bgResList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  bgResIndex = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: bgResIndex != index
                      ? null
                      : Border.all(
                          color: Colors.black,
                          width: 3.w,
                        ),
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: Image.asset(
                  bgResList[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClosePage(
      child: MyScaffold(
        padding: EdgeInsets.zero,
        body: () {
          return Container(
            padding: EdgeInsets.only(top: 58.w, left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContent().center(),
                _buildSelect(),
                Spacer(),
                _buildShare(),
              ],
            ),
          );
        },
      ),
    );
  }
}

///
class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    super.key,
    required this.data,
    required this.asset,
  });

  ///
  final DbCountdownEntity data;

  ///
  final String asset;

  ///
  Widget _buildContentTip() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Color(0xFFAAAAAB),
          fontSize: 16.sp,
        ),
        children: [
          if (data.tipText != null)
            TextSpan(
              text: '距离 ',
            ),
          TextSpan(
            text: data.name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          if (data.tipText != null)
            TextSpan(
              text: ' ${data.tipText}',
            ),
        ],
      ),
    );
  }

  ///
  Widget _buildCountDays() {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 40.sp),
        children: [
          TextSpan(
            text: data.differenceDays == 0
                ? '今天'
                : '${data.differenceDays}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          if (data.differenceDays != 0)
            TextSpan(
              text: ' 天',
              style: TextStyle(
                color: Color(0xFF989898),
                fontSize: 18.sp,
              ),
            ),
        ],
      ),
    );
  }

  ///
  Widget _buildCountdown() {
    Widget nameWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${data.name}',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 3.w),
        Text(
          '${formatDate(
            DateTime.parse(data.dateTime!),
            [yyyy, '年', mm, '月', dd, '日'],
          )}',
          style: TextStyle(
            fontSize: 9.sp,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ],
    );

    Widget tagWidget = Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          AssetsRes.SHARE_TAG,
          height: 21.w,
        ),
        Text(
          '倒数日',
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.white,
          ),
        ),
      ],
    );

    Widget countdownWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildContentTip(),
        _buildCountDays(),
      ],
    );

    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Image.asset(
            asset,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Positioned(
            top: 18.w,
            left: 20.w,
            child: nameWidget,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: tagWidget,
          ),
          Center(child: countdownWidget),
        ],
      ),
    );
  }

  ///
  Widget _buildDashLine() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: DottedLine(),
    );
  }

  ///
  Widget _buildInfo() {
    return Container(
      height: 63.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Container(
            height: 30.w,
            width: 30.w,
            child: Placeholder(),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hey~',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '扫描二维码下载倒数日',
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 30.w,
            width: 30.w,
            child: Placeholder(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 218.w,
      child: Column(
        children: [
          _buildCountdown(),
          _buildDashLine(),
          _buildInfo(),
        ],
      ),
    );
  }
}
