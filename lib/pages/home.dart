import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      height: 94.w,
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
      onPressed: () {},
      icon: Icon(
        Icons.settings,
        size: 26.w,
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
                  margin: EdgeInsets.only(top: 20.w),
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
