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
      _allItems = value;
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

  /// TODO : 置顶
  void top(DbCountdownEntity item) {}

  /// 删除
  void delete(DbCountdownEntity item) {
    countdownService.delete(item);
  }
}
