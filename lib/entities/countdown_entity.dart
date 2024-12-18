import 'package:count_down/db/db_manager.dart';
import 'package:count_down/generated/json/base/json_convert_content.dart';
import 'package:count_down/generated/json/base/json_field.dart';
import 'package:count_down/generated/json/countdown_entity.g.dart';
import 'package:count_down/widgets/picker/repeat_picker.dart';
import 'package:flutter/material.dart';

@JsonSerializable()
class DbCountdownEntity {
  ///
  String? key;

  ///
  String? name;

  /// 日期时间
  String? dateTime;

  /// 是否全天
  bool isAllDay;

  /// 重复类型  - CountdownRepeatType
  String? repeat;

  /// 提前提醒 (天数)
  /// 0: 当天
  int? remindAdvance;

  /// 标签
  String? tagKey;

  /// 是否完成
  bool isDone;

  /// 置顶时间
  String? topDateTime;

  ///
  String? iconAsset;

  ///
  int? iconColorValue;

  ///
  DbCountdownEntity({
    this.key,
    this.name,
    this.dateTime,
    this.isAllDay = true,
    this.repeat,
    this.remindAdvance,
    this.tagKey,
    this.isDone = false,
  });

  factory DbCountdownEntity.fromJson(Map<String, dynamic> json) =>
      DbCountdownEntity();

  Map<String, dynamic> toJson() => $DbCountdownEntityToJson(this);

  ///
  Map<String, Object?> toSqlRaw() {
    return {
      DbManager().columnKey: key ?? name,
      DbManager().columnName: name,
      DbManager().columnDateTime: dateTime,
      DbManager().columnIsAllDay: isAllDay ? 1 : 0,
      DbManager().columnRepeat: repeat,
      DbManager().columnRemindAdvance: remindAdvance,
      DbManager().columnTagKey: tagKey,
      DbManager().columnIsDone: isDone ? 1 : 0,
      DbManager().columnTopDateTime: topDateTime,
      DbManager().columnIconAsset: iconAsset,
      DbManager().columnIconColorValue: iconColorValue,
    };
  }

  ///
  factory DbCountdownEntity.fromSqlRaw(Map<String, dynamic> json) {
    final dbTagEntity = DbCountdownEntity();
    final String? key =
        jsonConvert.convert<String>(json[DbManager().columnKey]);
    if (key != null) {
      dbTagEntity.key = key;
    }
    final String? name =
        jsonConvert.convert<String>(json[DbManager().columnName]);
    if (name != null) {
      dbTagEntity.name = name;
    }
    final String? dateTime =
        jsonConvert.convert<String>(json[DbManager().columnDateTime]);
    if (dateTime != null) {
      dbTagEntity.dateTime = dateTime;
    }
    final int? isAllDay =
        jsonConvert.convert<int>(json[DbManager().columnIsAllDay]);
    if (isAllDay != null) {
      dbTagEntity.isAllDay = isAllDay == 1;
    }
    final String? repeat =
        jsonConvert.convert<String>(json[DbManager().columnRepeat]);
    if (repeat != null) {
      dbTagEntity.repeat = repeat;
    }
    final int? remindAdvance =
        jsonConvert.convert<int>(json[DbManager().columnRemindAdvance]);
    if (remindAdvance != null) {
      dbTagEntity.remindAdvance = remindAdvance;
    }
    final String? tagKey =
        jsonConvert.convert<String>(json[DbManager().columnTagKey]);
    if (tagKey != null) {
      dbTagEntity.tagKey = tagKey;
    }
    final int? isDone =
        jsonConvert.convert<int>(json[DbManager().columnIsDone]);
    if (isDone != null) {
      dbTagEntity.isDone = isDone == 1;
    }
    final String? topDateTime =
        jsonConvert.convert<String>(json[DbManager().columnTopDateTime]);
    if (topDateTime != null) {
      dbTagEntity.topDateTime = topDateTime;
    }
    final String? iconAsset =
        jsonConvert.convert<String>(json[DbManager().columnIconAsset]);
    if (iconAsset != null) {
      dbTagEntity.iconAsset = iconAsset;
    }
    final int? iconColorValue =
        jsonConvert.convert<int>(json[DbManager().columnIconColorValue]);
    if (iconColorValue != null) {
      dbTagEntity.iconColorValue = iconColorValue;
    }
    return dbTagEntity;
  }

  /// 目标日期
  DateTime get targetDateTime {
    var date = DateTime.parse(dateTime!);
    var currentData = DateTime.now().copyWith(hour: 0, minute: 0);
    switch (CountdownRepeatType.fromName(repeat!)) {
      case CountdownRepeatType.weekly:
        var differDay = date.weekday - DateTime.now().weekday;
        date = currentData.add(Duration(days: differDay));
      case CountdownRepeatType.monthly:
        date = date.copyWith(
          year: currentData.year,
          month: currentData.month,
        );
      case CountdownRepeatType.yearly:
        date = date.copyWith(
          year: currentData.year,
        );
      default:
    }
    return date;
  }

  /// 日期已经过去返回‘过去’
  /// 日期没到返回‘还有’
  /// 日期是当天返回 ‘’
  String? get tipText {
    var currentDate = DateTime.now();
    if (currentDate.day == targetDateTime.day &&
        currentDate.month == targetDateTime.month &&
        currentDate.year == targetDateTime.year) {
      return null;
    } else if (currentDate.isAfter(targetDateTime)) {
      return '过去';
    } else if (currentDate.isBefore(targetDateTime)) {
      return '还有';
    }
    return null;
  }

  /// 返回和目标日期相差多少天
  int get differenceDays {
    var currentDate = DateTime.now();
    currentDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );
    // if (currentDate.day == targetDateTime.day &&
    //     currentDate.month == targetDateTime.month &&
    //     currentDate.year == targetDateTime.year) {
    //   return '今天';
    // }
    var mTargetDateTime = DateTime(
      targetDateTime.year,
      targetDateTime.month,
      targetDateTime.day,
    );
    return mTargetDateTime.difference(currentDate).inDays.abs();
  }

  ///
  Color? get iconColor {
    if (iconColorValue != null) {
      return Color(iconColorValue!);
    }
    return null;
  }
}
