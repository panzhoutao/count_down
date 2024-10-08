import 'package:logger/logger.dart';

Logger logger = Logger(printer: PrettyPrinter());

class Log {
  static dynamic i(dynamic info) {
    logger.i(info);
  }

  static dynamic t(dynamic info) {
    logger.t(info);
  }

  static dynamic d(dynamic info) {
    logger.d(info);
  }

  static dynamic w(dynamic info) {
    logger.w(info);
  }

  static dynamic e(
    dynamic info, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.e(
      info,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static dynamic f(dynamic info) {
    logger.f(info);
  }
}
