import 'package:count_down/main.dart';
import 'package:count_down/pages/home/home.dart';
import 'package:count_down/style/theme_data.dart';
import 'package:count_down/widgets/app_bar.dart';
import 'package:count_down/widgets/base_state.dart';
import 'package:count_down/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';

///
class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({super.key});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends BaseState<ItemDetailPage> {
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
    return Text('距离 XXX 还有');
  }

  ///
  Widget _buildCountDays() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Text('1天'),
    );
  }

  ///
  Widget _buildDate() {
    return _container();
  }

  ///
  Widget _buildRepeat() {
    return _container();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      padding: EdgeInsets.zero,
      appBar: MyAppBar(
        leftWidget: Container(),
        rightWidget: GestureDetector(
          onTap: () {},
          child: PopupMenuButton<String>(
            icon: Icon(Icons.more_horiz),
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
          ),
        ),
      ),
      body: () {
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
            Spacer(),
            _buildShare(),
          ],
        );
      },
    );
  }
}

///
Widget _container() {
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
            '目标日期',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 12.w),
          child: Text('2023-01-01'),
        ).expand(),
      ],
    ),
  );
}
