import 'package:count_down/entities/tag_entity.dart';
import 'package:count_down/pages/countdown_detail/countdown_detail.dart';
import 'package:count_down/pages/home/countdown/countdown_view.dart';
import 'package:count_down/pages/home/countdown/logic.dart';
import 'package:count_down/res/assets_res.dart';
import 'package:count_down/router_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_utils_code/flutter_utils_code.dart';
import 'package:get/get.dart';

///
class HomeCountdownWidget extends StatefulWidget {
  const HomeCountdownWidget({super.key});

  @override
  State<HomeCountdownWidget> createState() => _HomeCountdownWidgetState();
}

class _HomeCountdownWidgetState extends State<HomeCountdownWidget> {
  ///
  final _logic = Get.put(HomeCountdownLogic());

  ///
  ListView _buildTags() {
    List<DbTagEntity> tags = _logic.tags;
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(right: 20.w),
      itemBuilder: (context, index) {
        DbTagEntity tag = tags[index];
        return _TagItemWidget(
          title: tag.name!,
          selected: _logic.currentTag?.key == tag.key,
          onTap: () {
            _logic.selectTag(tag);
          },
        );
      },
      separatorBuilder: (_, index) => SizedBox(width: 10.w),
      itemCount: tags.length,
    );
  }

  ///
  Widget _buildAllTag() {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 10.w),
      child: _TagItemWidget(
        title: '全部',
        selected: _logic.isAll,
        onTap: () {
          _logic.selectAllTag();
        },
      ),
    );
  }

  ///
  Widget _buildTagWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildAllTag(),
          _buildTags(),
        ],
      ),
    );
  }

  ///
  Widget _buildList() {
    if (_logic.items.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetsRes.EMPTY_DATA),
          SizedBox(height: 20.w),
          Text(
            '暂无倒数日',
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xFF919191),
            ),
          ),
          Text(
            '点击“+”按钮进行创建',
            style: TextStyle(
              fontSize: 12.sp,
              color: Color(0xFF919191),
            ),
          ),
        ],
      );
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        var item = _logic.items[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          height: 74.w,
          child: Slidable(
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              extentRatio: 0.36,
              children: [
                Spacer(),
                Container(
                  width: 53.w,
                  height: 53.w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _logic.top(item);
                    },
                    child: SvgPicture.asset(AssetsRes.ITEM_TOP),
                  ),
                ),
                Spacer(),
                Container(
                  width: 53.w,
                  height: 53.w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _logic.delete(item);
                    },
                    child: SvgPicture.asset(AssetsRes.ITEM_DELETE),
                  ),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                showCupertinoModalSheet(
                  context: context,
                  builder: (context) => CountdownDetailPage(keyId: item.key!),
                );
              },
              child: HomeCountdownItemWidget(data: item),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10.w);
      },
      itemCount: _logic.items.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCountdownLogic>(
      builder: (controller) {
        return Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              height: 34.w,
              child: _buildTagWidget(),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.w),
              child: _buildList(),
            ).expand(),
          ],
        );
      },
    );
  }
}

///
class _TagItemWidget extends StatelessWidget {
  const _TagItemWidget({
    super.key,
    required this.title,
    required this.selected,
    this.onTap,
  });

  ///
  final String title;

  ///
  final bool selected;

  ///
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.w),
            topRight: Radius.circular(6.w),
            bottomRight: Radius.circular(20.w),
            bottomLeft: Radius.circular(6.w),
          ),
        ),
        constraints: BoxConstraints(minWidth: 70.w),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : Color(0xFF919191),
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
