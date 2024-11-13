import 'package:count_down/pages/add_tag/add_tag.dart';
import 'package:count_down/pages/settings/sort_and_tag/logic.dart';
import 'package:count_down/router_manage.dart';
import 'package:count_down/services/tag_service.dart';
import 'package:count_down/utils/log_util.dart';
import 'package:count_down/widgets/base_state.dart';
import 'package:count_down/widgets/page.dart';
import 'package:count_down/widgets/scaffold.dart';
import 'package:count_down/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';
import 'package:get/get.dart';

///
class SortAndTagPage extends StatefulWidget {
  const SortAndTagPage({super.key});

  @override
  State<SortAndTagPage> createState() => _SortAndTagPageState();
}

class _SortAndTagPageState extends BaseState<SortAndTagPage> {
  ///
  late SortAndTagController _logic;

  ///
  Widget _buildTitle() {
    return Text('首页显示');
  }

  ///
  Widget _buildList() {
    return Obx(() {
      var list = TagService.to.tagList;
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          var item = list[index];
          return Container(
            height: 53.w,
            margin: EdgeInsets.only(top: 10.w),
            child: Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                extentRatio: 0.2,
                children: [
                  Spacer(),
                  Container(
                    width: 53.w,
                    height: 53.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _logic.delete(item);
                      },
                    ),
                  ),
                ],
              ),
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal :16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.menu),
                    Text('${item.name}'),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClosePage(
      child: MyScaffold(
        appBar: WidgetExtends.appBar(
          title: '分类与标签',
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showCupertinoModalSheet(
              context: context,
              builder: (context) => AddTagPage(),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: () {
          return GetBuilder<SortAndTagController>(
            init: SortAndTagController(),
            builder: (controller) {
              _logic = controller;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
                  _buildList().expand(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
