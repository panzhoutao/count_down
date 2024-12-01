import 'package:count_down/entities/countdown_entity.dart';
import 'package:count_down/pages/countdown_detail/logic.dart';
import 'package:count_down/pages/edit_countdown/edit_countdown.dart';
import 'package:count_down/router_manage.dart';
import 'package:count_down/services/countdown_service.dart';
import 'package:count_down/services/tag_service.dart';
import 'package:count_down/style/theme_data.dart';
import 'package:count_down/utils/remind_advance_utils.dart';
import 'package:count_down/widgets/app_bar.dart';
import 'package:count_down/widgets/base_state.dart';
import 'package:count_down/widgets/picker/repeat_picker.dart';
import 'package:count_down/widgets/scaffold.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';
import 'package:get/get.dart';

///
class CountdownDetailPage extends StatefulWidget {
  const CountdownDetailPage({
    super.key,
    required this.keyId,
  });

  ///
  final String keyId;

  @override
  State<CountdownDetailPage> createState() => _CountdownDetailPageState();
}

class _CountdownDetailPageState extends BaseState<CountdownDetailPage> {
  ///
  late CountdownDetailLogic _logic;

  ///
  Widget _buildImage() {
    return Container();
  }

  ///
  Widget _buildShare() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(),
        child: Text('分享'),
      ),
    );
  }

  ///
  Widget _buildContent() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Color(0xFFAAAAAB),
          fontSize: 20.sp,
        ),
        children: [
          if (_logic.data.tipText != null)
            TextSpan(
              text: '距离 ',
            ),
          TextSpan(
            text: _logic.data.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          if (_logic.data.tipText != null)
            TextSpan(
              text: ' ${_logic.data.tipText}',
            ),
        ],
      ),
    );
  }

  ///
  Widget _buildCountDays() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Text(_logic.data.differenceDays == 0
          ? '今天'
          : '${_logic.data.differenceDays}天'),
    );
  }

  ///
  Widget _buildDate() {
    return _container(
      title: '目标日期',
      value: formatDate(
        _logic.data.targetDateTime,
        [yyyy, '年', mm, '月', dd, '日'],
      ),
    );
  }

  ///
  Widget _buildRepeat() {
    String repeatText = CountdownRepeatType.fromName(_logic.data.repeat!).text;
    return _container(
      title: '重复',
      value: repeatText,
    );
  }

  ///
  Widget _buildTip() {
    return _container(
      title: '提醒',
      value: RemindAdvanceUtils.getRemindAdvanceText(_logic.data.remindAdvance)?? '未设置',
    );
  }

  ///
  Widget _buildTag() {
    String tagText = '无';
    if (_logic.data.tagKey != null) {
      TagService.to.findTagByKey(_logic.data.tagKey!).name!;
    }
    return _container(
      title: '标签',
      value: tagText,
    );
  }

  ///
  void _edit() {
    showCupertinoModalSheet(
      context: context,
      builder: (context) => EditCountdownPage(entity: _logic.data),
    ).then((value) {
      _logic.updateData();
    });
  }

  ///
  void _delete() {
    CountdownService.to.delete(_logic.data).then((value) {
      if (value) {
        Navigator.of(Get.context!).pop();
      }
    });
  }

  ///
  Widget _buildMenu() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_horiz),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.w),
      ),
      offset: Offset(-10, 0),
      position: PopupMenuPosition.under,
      onSelected: (value) {
        switch (value) {
          case '置顶':
            _logic.setTop();
            break;
          case '编辑':
            _edit();
            break;
          case '完成':
            _logic.complete();
            break;
          case '删除':
            _delete();
            break;
        }
      },
      itemBuilder: (context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: '置顶',
            child: Text('置顶'),
          ),
          PopupMenuItem<String>(
            value: '编辑',
            child: Text('编辑'),
          ),
          PopupMenuItem<String>(
            value: '完成',
            child: Text('完成'),
          ),
          PopupMenuItem<String>(
            value: '删除',
            child: Text('删除'),
          ),
        ];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      padding: EdgeInsets.zero,
      appBar: MyAppBar(
        leftWidget: Container(),
        rightWidget: _buildMenu(),
      ),
      body: () {
        return GetBuilder<CountdownDetailLogic>(
          init: CountdownDetailLogic(widget.keyId),
          builder: (controller) {
            _logic = controller;
            return Column(
              children: [
                _buildImage(),
                _buildContent(),
                _buildCountDays(),
                Row(
                  children: [
                    _buildDate().expand(),
                    SizedBox(width: 23.w),
                    _buildRepeat().expand(),
                  ],
                ).padding(MyThemeData.instance.primaryPadding),
                SizedBox(height: 10.w),
                Row(
                  children: [
                    _buildTip().expand(),
                    SizedBox(width: 23.w),
                    _buildTag().expand(),
                  ],
                ).padding(MyThemeData.instance.primaryPadding),
                Spacer(),
                _buildShare(),
              ],
            );
          },
        );
      },
    );
  }
}

///
Widget _container({
  required String title,
  required String value,
}) {
  return Container(
    height: 76.w,
    decoration: BoxDecoration(
      color: Color(0xFFE2EEFF),
      borderRadius: BorderRadius.circular(16.w),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 85.w,
          height: 34.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF599BF9),
                Color(0xFFAFDDFF),
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.w),
              bottomRight: Radius.circular(16.w),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 12.w),
          child: Text(value),
        ).expand(),
      ],
    ),
  );
}
