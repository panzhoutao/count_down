import 'package:count_down/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
class CountdownIcon extends StatelessWidget {
  const CountdownIcon({
    super.key,
    this.asset,
    this.color,
  });

  ///
  final String? asset;

  ///
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Color(0xFFFBE1ED),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: SvgPicture.asset(
        asset ?? AssetsRes.COUNTDOWN_ICON_1,
      ),
    );
  }
}
