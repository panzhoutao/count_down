import 'package:count_down/pages/icon_edit/icon_edit/logic.dart';
import 'package:count_down/res/assets_res.dart';
import 'package:count_down/style/icon.dart';
import 'package:count_down/widgets/countdown_icon.dart';
import 'package:count_down/widgets/page.dart';
import 'package:count_down/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';
import 'package:get/get.dart';

///
class IconEditPage extends StatefulWidget {
  const IconEditPage({
    super.key,
    required this.onConfirm,
  });

  ///
  final Function(String asset, Color color) onConfirm;

  @override
  State<IconEditPage> createState() => _IconEditPageState();
}

class _IconEditPageState extends State<IconEditPage> {
  ///
  late IconEditLogic _logic;

  ///
  String asset = IconDataList.defaultIcon;

  ///
  Color color = IconColor.defaultColor;

  ///
  List<Color> colors = [
    IconColor.defaultColor,
    IconColor.color1,
    IconColor.color2,
    IconColor.color3,
    IconColor.color4,
    IconColor.color5,
    IconColor.color6,
  ];

  ///
  List<String> icons = [
    IconDataList.defaultIcon,
    IconDataList.icon1,
    IconDataList.icon2,
    IconDataList.icon3,
    IconDataList.icon4,
  ];

  @override
  void initState() {
    super.initState();
  }

  ///
  Widget _buildIcon() {
    return SizedBox(
      width: 100.w,
      height: 100.w,
      child: CountdownIcon(
        color: color,
        asset: asset,
      ),
    );
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
              widget.onConfirm(asset, color);
              Navigator.of(context).pop();
            },
            child: Text('确定'),
          ).expand(),
        ],
      ),
    );
  }

  ///
  Widget _buildColorItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '选择背景颜色',
          style: TextStyle(color: Color(0xFF575757)),
        ).paddingOnly(top: 20.w,bottom: 10.w),
        GridView.builder(
          shrinkWrap: true,
          itemCount: colors.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 10.w,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  color = colors[index];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: colors[index],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color == colors[index]
                        ? Colors.black
                        : Colors.transparent,
                    width: 5.w,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  ///
  Widget _buildIconItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '选择图片',
          style: TextStyle(color: Color(0xFF575757)),
        ).paddingOnly(top: 20.w,bottom: 10.w),
        GridView.builder(
          shrinkWrap: true,
          itemCount: icons.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 10.w,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  asset = icons[index];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(12.w),
                  border: Border.all(
                    color: asset == icons[index]
                        ? Colors.black
                        : Colors.transparent,
                    width: 5.w,
                  ),
                ),
                child: SvgPicture.asset(icons[index]),
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
          return GetBuilder(
            init: IconEditLogic(),
            builder: (controller) {
              _logic = controller;
              return Container(
                padding: EdgeInsets.only(top: 58.w),
                width: double.infinity,
                child: Column(
                  children: [
                    Column(
                      children: [
                        _buildIcon(),
                        _buildColorItems(),
                        _buildIconItems(),
                      ],
                    ).padding(EdgeInsets.symmetric(horizontal: 20.w)),
                    Spacer(),
                    _buildBottom(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
