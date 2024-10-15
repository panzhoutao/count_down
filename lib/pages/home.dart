import 'package:count_down/pages/settings/settings.dart';
import 'package:count_down/router_manage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        // Get.toNamed(RoutersManager.settings);
        // Get.to(
        //   () => SettingsPage(),
        //   transition: Transition.native,
        // );
        // showCupertinoModalPopup(context: context, builder: builder)
        // Navigator.of(context).push(CupertinoPageRoute(builder: builder));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
