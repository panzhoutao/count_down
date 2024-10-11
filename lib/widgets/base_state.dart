import 'package:count_down/style/theme_data.dart';
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

  ///
  PreferredSizeWidget defaultAppbar({
    String title = '',
    Widget? titleWidget,
    List<Widget>? actions,
    bool automaticallyImplyLeading = true,
    bool? centerTitle,
    Color backgroundColor = Colors.white,
    Widget? leading,
    GestureTapCallback? leadingOnTap,
    double? leadingWidth = 300,
  }) {
    leading ??= GestureDetector(
      onTap: leadingOnTap ?? () => Get.backLegacy(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_back_ios, size: 24.w),
            Obx(
                  () => Text(
                backActionText.value,
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return AppBar(
      titleSpacing: titleWidget == null ? null : 0,
      title: titleWidget ?? Text(title),
      actions: [...actions ?? [], SizedBox(width: 20.w)],
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      leading: leading,
      leadingWidth: leadingWidth,
    );
  }

  ///
  Widget defaultScaffold({
    PreferredSizeWidget? appBar,
    EdgeInsetsGeometry? padding,
    Widget Function()? body,
    Color? backgroundColor,
  }) {
    padding ??= MyThemeData.instance.primaryPadding;

    Scaffold scaffold = Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: futureBuilderFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          debugPrint('${T.toString()} ${snapshot.connectionState}');

          Widget view = Container();

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              view = const Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                debugPrint('${snapshot.error}');
                // view = _errorWidget(snapshot.error);
                view = Container();
              } else {
                view = Padding(padding: padding!, child: body?.call());
              }
              break;
            default:
              break;
          }
          return view;
        },
      ),
    );

    return KeyboardDismissOnTap(child: scaffold);
  }
}
