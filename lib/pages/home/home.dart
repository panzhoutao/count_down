import 'package:count_down/pages/countdown/edit_countdown.dart';
import 'package:count_down/pages/countdown/countdown_detail.dart';
import 'package:count_down/pages/home/countdown/view.dart';
import 'package:count_down/pages/settings/settings.dart';
import 'package:count_down/router_manage.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';

///
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///
  Widget _buildBackground() {
    return Container(
      height: 94,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color(0xFF62ABFF),
          Color(0x0062ABFF),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
    );
  }

  ///
  Widget _buildSetting() {
    return IconButton(
      onPressed: () {
        showCupertinoModalSheet(
          context: context,
          builder: (context) => SettingsPage(),
        );
      },
      icon: Icon(
        Icons.settings,
        size: 26,
        color: Colors.black,
      ),
    );
  }

  ///
  void _addItem() {
    showCupertinoModalSheet(
      context: context,
      builder: (context) => EditCountdownPage(),
    );
  }

  ///
  Widget _buildDate() {
    String dateText = formatDate(DateTime.now(), [mm, '月', dd, '日']);
    return GestureDetector(
      onTap: () {
        // Get.toNamed(RoutersManager.itemDetail);
      },
      child: Text(
        dateText,
        style: TextStyle(
          fontSize: 40.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 20),
                  child: _buildSetting(),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 20.w, bottom: 30.w),
                  child: _buildDate(),
                ),
                HomeCountdownWidget().expand(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
