import 'package:count_down/entities/countdown_entity.dart';
import 'package:count_down/pages/icon_edit/icon_edit/view.dart';
import 'package:count_down/res/assets_res.dart';
import 'package:count_down/router_manage.dart';
import 'package:count_down/style/theme_data.dart';
import 'package:count_down/widgets/app_bar.dart';
import 'package:count_down/widgets/base_state.dart';
import 'package:count_down/widgets/countdown_icon.dart';
import 'package:count_down/widgets/picker/date_picker.dart';
import 'package:count_down/widgets/picker/repeat_picker.dart';
import 'package:count_down/widgets/picker/tag_picker.dart';
import 'package:count_down/widgets/picker/timing_reminder_picker.dart';
import 'package:count_down/widgets/scaffold.dart';
import 'package:count_down/widgets/picker/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'logic.dart';

/// 条目
/// 添加 、详情
class EditCountdownPage extends StatefulWidget {
  const EditCountdownPage({
    super.key,
    this.entity,
  });

  ///
  final DbCountdownEntity? entity;

  @override
  State<EditCountdownPage> createState() => _EditCountdownPageState();
}

class _EditCountdownPageState extends BaseState<EditCountdownPage> {
  ///
  late EditCountdownController _logic;

  @override
  void initState() {
    super.initState();
  }

  /// 选择日期
  void _selectDate() {
    showMyDatePicker().then((value) {
      if (value != null) {
        _logic.setDate(value);
      }
    });
  }

  /// 选择时间
  void _selectTime() {
    showMyTimePicker(
      onPicker: (bool isAllDay, [Duration? value]) {
        _logic.setTime(isAllDay: isAllDay, value: value);
      },
    );
  }

  /// 选择重复
  void _selectRepeat() {
    showMyRepeatPicker((value) {
      _logic.setRepeat(value);
    });
  }

  /// 选择提前提醒
  void _selectTimingReminder() {
    showRemindAdvancePicker((value) {
      _logic.setRemindAdvance(value);
    });
  }

  /// 选择标签
  void _selectTag() {
    showMySelectTagPicker((value) {
      _logic.setTag(value);
    });
  }

  ///
  Widget _buildName() {
    return TextField(
      controller: _logic.nameController,
      onChanged: (value) {
        _logic.setName(value);
      },
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18.sp),
      decoration: InputDecoration(
        hintText: '请在这里输入事件名称',
        hintStyle: TextStyle(color: Color(0xFF979797)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyThemeData.instance.seedColor,
            width: 2.w,
          ), // 未获取焦点时的下划线颜色
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyThemeData.instance.seedColor,
            width: 2.w,
          ), // 获取焦点时的下划线颜色
        ),
      ),
    );
  }

  ///
  Widget _buildContainer1() {
    return _container(
      Column(
        children: [
          _listTile(
            title: '日期',
            icon: AssetsRes.SETTINGS_TAG,
            contentText: _logic.dateText,
            onTap: _selectDate,
          ),
          _listTile(
            title: '提醒时间',
            icon: AssetsRes.SETTINGS_TAG,
            contentText: _logic.timeText,
            contentHintText: '全天',
            onTap: _selectTime,
          ),
        ],
      ),
    );
  }

  ///
  Widget _buildContainer2() {
    return _container(
      Column(
        children: [
          _listTile(
            title: '重复',
            icon: AssetsRes.SETTINGS_TAG,
            contentText: _logic.repeatText,
            contentHintText: '不重复',
            onTap: _selectRepeat,
          ),
          _listTile(
            title: '提前提醒',
            icon: AssetsRes.SETTINGS_TAG,
            contentText: _logic.remindAdvanceText,
            contentHintText: '未设置',
            onTap: _selectTimingReminder,
          ),
          _listTile(
            title: '标签',
            icon: AssetsRes.SETTINGS_TAG,
            contentText: _logic.tagText,
            contentHintText: '无',
            onTap: _selectTag,
          ),
        ],
      ),
    );
  }

  ///
  Widget _actionWidget() {
    if (widget.entity?.key == null) {
      return ElevatedButton(
        onPressed: () {
          _logic.save();
        },
        child: Text('添加'),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          _logic.save();
        },
        child: Text('保存'),
      );
    }
  }

  ///
  Widget _buildIcon() {
    return GestureDetector(
      onTap: () {
        showCupertinoModalSheet(
          context: context,
          builder: (context) => IconEditPage(
            onConfirm: (String asset, Color color) {
              _logic.setIcon(asset, color.value);
            },
          ),
        );
      },
      child: SizedBox(
        height: 110.w,
        width: 110.w,
        child: Stack(
          children: [
            SizedBox(
              width: 100.w,
              height: 100.w,
              child: CountdownIcon(
                asset: _logic.iconAsset,
                color: _logic.iconColor,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                AssetsRes.EDIT_COUNTDOWN_EDIT_ICON,
                width: 25.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: MyAppBar(
        rightWidget: _actionWidget().paddingOnly(right: 10.w),
      ),
      body: () {
        return GetBuilder<EditCountdownController>(
          init: EditCountdownController(widget.entity),
          builder: (controller) {
            _logic = controller;
            return Column(
              children: [
                SizedBox(height: 30.w),
                _buildIcon(),
                _buildName().paddingSymmetric(vertical: 25.w, horizontal: 30.w),
                _buildContainer1(),
                _buildContainer2(),
              ],
            );
          },
        );
      },
    );
  }
}

///
Widget _container(Widget child) {
  return Container(
    // padding: EdgeInsets.symmetric(horizontal: 30.w),
    margin: EdgeInsets.only(bottom: 20.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.w),
    ),
    child: child,
  );
}

///
Widget _listTile({
  required String title,
  required String icon,
  String? contentText,
  String? contentHintText,
  required Function() onTap,
}) {
  String text = contentText ?? contentHintText ?? '';
  Color textColor = contentText == null ? Color(0xFF989898) : Colors.black;
  return ListTile(
    leading: SvgPicture.asset(icon),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 14.sp, color: textColor),
        ),
        Icon(Icons.arrow_drop_down, color: Color(0xFF989898)),
      ],
    ),
    title: Text(
      title,
      style: TextStyle(fontSize: 14.sp, color: Color(0xFF979797)),
    ),
    onTap: onTap,
  );
}
