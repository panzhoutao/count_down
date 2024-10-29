import 'package:count_down/entities/item_entity.dart';
import 'package:count_down/pages/item/logic.dart';
import 'package:count_down/res/assets_res.dart';
import 'package:count_down/widgets/base_state.dart';
import 'package:count_down/widgets/bottom_sheet.dart';
import 'package:count_down/widgets/date_picker.dart';
import 'package:count_down/widgets/page.dart';
import 'package:count_down/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// 条目
/// 添加 、详情
class ItemPage extends StatefulWidget {
  const ItemPage({
    super.key,
    this.entity,
  });

  ///
  final ItemEntity? entity;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends BaseState<ItemPage> {
  ///
  late ItemController _logic;

  /// 选择日期
  void _selectDate() {
    showMyDatePicker();
  }

  /// 选择时间
  void _selectTime() {}

  /// 选择重复
  void _selectRepeat() {}

  /// 选择定时提醒
  void _selectTimingReminder() {}

  /// 选择标签
  void _selectTag() {}

  ///
  Widget _buildName() {
    return TextField(
      controller: _logic.nameController,
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
            title: '时间',
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
            title: '定时提醒',
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
    return AddPage(
      onAdd: () {
        _logic.save();
      },
      child: MyScaffold(
        body: () {
          return GetBuilder<ItemController>(
            init: ItemController(),
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
      ),
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
