import 'package:flutter/foundation.dart';

mixin HandleExceptionMixin {
  handelException(dynamic e, {String? subTitle}) {
    log(e, subTitle: subTitle);
  }

  void log(dynamic e, {String? subTitle}) {
    String titleLog = runtimeType.toString();
    if (subTitle != null) titleLog += '.[$subTitle]';
    debugPrint(subTitle);
    if (kDebugMode) {
      print('\x1b[101m\x1b[30m$titleLog: $e}\x1b[0m');
    }
  }
}
