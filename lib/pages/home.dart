import 'package:count_down/pages/item/item_detail.dart';
import 'package:count_down/pages/settings/settings.dart';
import 'package:count_down/router_manage.dart';
import 'package:count_down/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';
import 'package:get/get.dart';

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
      builder: (context) => ItemPage(),
    );
  }

  ///
  Widget _buildDate() {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(RoutersManager.itemDetail);
      },
      child: Text(
        '1月1日',
        style: TextStyle(
          fontSize: 40.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ///
  Widget _buildTags() {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.w),
              topRight: Radius.circular(6.w),
              bottomRight: Radius.circular(20.w),
              bottomLeft: Radius.circular(6.w),
            ),
          ),
          constraints: BoxConstraints(
            minWidth: 70.w,
          ),
          alignment: Alignment.center,
          child: Text(
            'data',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          width: 10.w,
        );
      },
      itemCount: 10,
    );
  }

  ///
  Widget _buildList() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          height: 74.w,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.w),
          ),
          child: Container(),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10.w);
      },
      itemCount: 10,
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
                  margin: EdgeInsets.only(left: 20.w),
                  child: _buildDate(),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  height: 34.w,
                  margin: EdgeInsets.only(top: 30.w),
                  child: _buildTags(),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 20.w),
                  child: _buildList(),
                ).expand(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
