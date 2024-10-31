import 'package:count_down/router_manage.dart';
import 'package:count_down/widgets/app_bar.dart';
import 'package:count_down/widgets/base_state.dart';
import 'package:count_down/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
class AddTagPage extends StatefulWidget {
  const AddTagPage({super.key});

  @override
  State<AddTagPage> createState() => _AddTagPageState();
}

class _AddTagPageState extends BaseState<AddTagPage> {
  /// 输入框 , 白色背景 ， 圆角
  Widget _buildInput() {
    return TextField(
      decoration: InputDecoration(
        hintText: '请输入标签名称',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(11.w),
        ),
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
            onPressed: () {},
            child: Text('添加'),
          ),
        ),
        title: '添加标签',
      ),
      body: () {
        return Container(
          margin: EdgeInsets.only(top: 20.w),
          child: _buildInput(),
        );
      },
    );
  }
}
