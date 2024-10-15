import 'package:count_down/utils/toast_utils.dart';
import 'package:flutter/material.dart';

///
abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ///
  Future? futureBuilderFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      postFrameCallback();
    });

    futureBuilderFuture = reloadData();
  }

  @protected
  Future reloadData() async {}

  /// build 后回调
  void postFrameCallback() {}

  @override
  void didChangeDependencies() {
    context.dependOnInheritedWidgetOfExactType();
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    clearAllFocus();
    Toast.closeAllLoading();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///
  void clearAllFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  ///
  void rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

}
