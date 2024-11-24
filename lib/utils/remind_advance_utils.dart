class RemindAdvanceUtils {
  ///
  static String getRemindAdvanceText(int? value) {
    if (value == null) {
      return '未设置';
    }
    switch (value) {
      case 0:
        return '当天';
      case 7:
        return '一周前';
      default:
        return '$value天前';
    }
  }
}
