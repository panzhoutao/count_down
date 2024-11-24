import 'package:count_down/entities/tag_entity.dart';
import 'package:count_down/pages/add_tag/add_tag.dart';
import 'package:count_down/router_manage.dart';
import 'package:count_down/services/tag_service.dart';
import 'package:count_down/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

///
void showMySelectTagPicker([Function(DbTagEntity? tag)? onConfirm]) {
  DbTagEntity? selectedTag;
  if (TagService.to.dataList.isNotEmpty) {
    selectedTag = TagService.to.dataList.first;
  }
  Get.bottomSheet(
    BottomSheetWidget(
      title: '选择标签',
      onConfirm: () {
        if (selectedTag != null) {
          onConfirm?.call(selectedTag);
        }
        Get.backLegacy();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.w),
        child: SelectTagWidget(
          onChange: (tag) {
            selectedTag = tag;
          },
        ),
      ),
    ),
  );
}

///
class SelectTagWidget extends StatefulWidget {
  const SelectTagWidget({super.key, this.onChange});

  ///
  final Function(DbTagEntity? tag)? onChange;

  @override
  State<SelectTagWidget> createState() => _SelectTagWidgetState();
}

class _SelectTagWidgetState extends State<SelectTagWidget> {
  ///
  DbTagEntity? _selectedTag;

  ///
  List<DbTagEntity> get _tags => TagService.to.dataList;

  @override
  void initState() {
    if (_tags.isNotEmpty) {
      _selectedTag = _tags.first;
    }
    super.initState();
  }

  ///
  Widget _buildAdd() {
    return GestureDetector(
      onTap: () {
        showCupertinoModalSheet(
          context: context,
          builder: (context) => AddTagPage(),
        ).then((value) {
          setState(() {
            if (_tags.isNotEmpty && _selectedTag == null) {
              _selectedTag = _tags.first;
            }
            widget.onChange?.call(_selectedTag);
          });
        });
      },
      child: _SelectTagWidget(
        icon: Icons.add,
        title: '添加标签',
        textColor: Color(0xFF979797),
        backgroundColor: Color(0xFFE2E2E2),
        iconColor: Color(0xFF979797),
      ),
    );
  }

  ///
  List<Widget> _listItem() {
    return _tags.map((e) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedTag = e;
          });
          widget.onChange?.call(e);
        },
        child: _SelectTagItemWidget(
          title: '${e.name}',
          selected: e == _selectedTag,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 10.w,
        runSpacing: 10.w,
        children: [
          ..._listItem(),
          _buildAdd(),
        ],
      ),
    );
  }
}

///
class _SelectTagItemWidget extends StatelessWidget {
  const _SelectTagItemWidget({
    super.key,
    required this.title,
    required this.selected,
  });

  ///
  final String title;

  ///
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: selected ? Colors.black : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: _SelectTagWidget(
        icon: selected
            ? Icons.check_circle
            : Icons.radio_button_unchecked_outlined,
        title: title,
        textColor: selected ? Colors.black : Color(0xFF979797),
        backgroundColor: selected ? Colors.white : Color(0xFFE2E2E2),
        iconColor: selected ? Colors.blue : Color(0xFF979797),
      ),
    );
  }
}

///
class _SelectTagWidget extends StatelessWidget {
  const _SelectTagWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.textColor,
    this.backgroundColor,
    required this.iconColor,
  });

  ///
  final IconData icon;

  ///
  final Color iconColor;

  ///
  final String title;

  ///
  final Color textColor;

  ///
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.w,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
