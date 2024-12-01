import 'package:count_down/entities/countdown_entity.dart';
import 'package:count_down/entities/tag_entity.dart';
import 'package:count_down/services/countdown_service.dart';
import 'package:count_down/services/tag_service.dart';
import 'package:get/get.dart';

///
class HomeCountdownLogic extends GetxController {
  ///
  final countdownService = CountdownService.to;

  ///
  final tagService = TagService.to;

  ///
  bool isAll = true;

  ///
  DbTagEntity? currentTag;

  ///
  List<DbTagEntity> tags = [];

  ///
  late List<DbCountdownEntity> _allItems;

  ///
  List<DbCountdownEntity> items = [];

  @override
  void onInit() {
    tagService.dataList.listenAndPump((value) {
      tags = value;
      if (currentTag != null) {
        var result = tags.firstWhereOrNull((e) => currentTag!.key == e.key);
        if (result == null) {
          selectAllTag();
        }
      }
      update();
    });
    countdownService.dataList.listenAndPump((value) {
      _allItems = countdownService.visibleList;
      // 按照置顶时间排序
      _allItems.sort((a, b) {
        if (a.topDateTime == null && b.topDateTime == null) {
          return 0;
        } else if (a.topDateTime == null && b.topDateTime != null) {
          return 1;
        } else if (a.topDateTime != null && b.topDateTime == null) {
          return -1;
        }
        var aTime = DateTime.parse(a.topDateTime!);
        var bTime = DateTime.parse(b.topDateTime!);
        return bTime.compareTo(aTime);
      });
      _changeItems();
    });
    super.onInit();
  }

  ///
  void selectAllTag() {
    isAll = true;
    currentTag = null;
    _changeItems();
  }

  ///
  void selectTag(DbTagEntity tag) {
    isAll = false;
    currentTag = tag;
    _changeItems();
  }

  ///
  void _changeItems() {
    items = _allItems.where((element) {
      return isAll || element.tagKey == currentTag?.key;
    }).toList();
    update();
  }

  /// 置顶
  void top(DbCountdownEntity item) {
    item.topDateTime = DateTime.now().toString();
    countdownService.update(item);
  }

  /// 删除
  void delete(DbCountdownEntity item) {
    countdownService.delete(item);
  }
}
