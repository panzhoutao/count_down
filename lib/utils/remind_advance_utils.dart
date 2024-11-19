class RemindAdvanceUtils {
  ///
  static String getRemindAdvanceText(int value) {
    switch (value) {
      case 0:
        return '当天前';
      case 7:
        return '一周前';
      default:
        return '$value天前';
    }
  }
}
