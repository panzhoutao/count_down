import 'package:count_down/entities/countdown_entity.dart';
import 'package:count_down/res/assets_res.dart';
import 'package:count_down/widgets/app_bar.dart';
import 'package:count_down/widgets/base_state.dart';
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

  ///
  var nameController = TextEditingController();

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
    showMyTimePicker();
  }

  /// 选择重复
  void _selectRepeat() {
    showMyRepeatPicker();
  }

  /// 选择提前提醒
  void _selectTimingReminder() {
    showMyTimingReminderPicker();
  }

  /// 选择标签
  void _selectTag() {
    showMySelectTagPicker();
  }

  ///
  Widget _buildName() {
    return TextField(
      controller: nameController,
      onChanged: (value) {
        _logic.setName(value);
      },
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: '请在这里输入事件名称',
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
            contentText: '2020',
            onTap: _selectDate,
          ),
          _listTile(
            title: '提醒时间',
            icon: AssetsRes.SETTINGS_TAG,
            contentText: '00:00',
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
            contentText: '',
            onTap: _selectRepeat,
          ),
          _listTile(
            title: '提前提醒',
            icon: AssetsRes.SETTINGS_TAG,
            contentText: '00:00',
            onTap: _selectTimingReminder,
          ),
          _listTile(
            title: '标签',
            icon: AssetsRes.SETTINGS_TAG,
            contentText: '',
            onTap: _selectTag,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: MyAppBar(
        rightWidget: GestureDetector(
          onTap: () {},
          child: ElevatedButton(
            onPressed: () {
              _logic.save();
            },
            child: Text('添加'),
          ),
        ),
      ),
      body: () {
        return GetBuilder<EditCountdownController>(
          init: EditCountdownController(widget.entity),
          builder: (controller) {
            _logic = controller;
            return Column(
              children: [
                _buildName(),
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
    margin: EdgeInsets.only(top: 20.w),
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
  required String contentText,
  required Function() onTap,
}) {
  return ListTile(
    leading: SvgPicture.asset(icon),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(contentText),
        Icon(Icons.arrow_drop_down),
      ],
    ),
    title: Text(title),
    onTap: onTap,
  );
}