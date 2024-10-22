import 'package:count_down/pages/settings/sort_and_tag/sort_and_tag.dart';
import 'package:count_down/res/assets_res.dart';
import 'package:count_down/router_manage.dart';
import 'package:count_down/widgets/base_state.dart';
import 'package:count_down/widgets/page.dart';
import 'package:count_down/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 设置
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends BaseState<SettingsPage> {
  ///
  List<_Item> _items1 = [];

  ///
  List<_Item> _items2 = [];

  @override
  void initState() {
    _items1 = [
      _Item(
        title: '分类与标签',
        icon: AssetsRes.SETTINGS_TAG,
        onTap: () {
          showCupertinoModalSheet(
            context: context,
            builder: (context) => SortAndTagPage(),
          );
        },
      ),
    ];
    super.initState();
  }

  ///
  Widget _buildTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        '设置',
        style: TextStyle(
          fontSize: 40.w,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ///
  Widget _buildItems(List<_Item> items) {
    return _container(
      Column(
        children: items.map((e) => _listTile(e)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClosePage(
      child: MyScaffold(
        body: () {
          return Container(
            padding: EdgeInsets.only(top: 58.w),
            child: Column(
              children: [
                _buildTitle(),
                _buildItems(_items1),
              ],
            ),
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
class _Item {
  final String title;
  final String icon;
  final Function() onTap;

  _Item({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

///
Widget _listTile(_Item item) {
  return ListTile(
    leading: SvgPicture.asset(item.icon),
    trailing: Icon(Icons.arrow_right),
    title: Text(item.title),
    onTap: item.onTap,
  );
}
