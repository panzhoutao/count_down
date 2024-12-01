import 'package:count_down/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
class CountdownIcon extends StatelessWidget {
  CountdownIcon({
    super.key,
  });

  ///
  final String asset = AssetsRes.COUNTDOWN_ICON_1;

  ///
  final Color color = Color(0xFFFBE1ED);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: SvgPicture.asset(
        asset,
      ),
    );
  }
}
