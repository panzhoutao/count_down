import 'package:count_down/style/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

///
class MyScaffold extends StatefulWidget {
  const MyScaffold({
    super.key,
    this.appBar,
    this.body,
    this.backgroundColor,
    this.padding, this.floatingActionButton,
  });

  ///
  final PreferredSizeWidget? appBar;

  ///
  final Widget Function()? body;

  ///
  final Color? backgroundColor;

  ///
  final EdgeInsetsGeometry? padding;

  ///
  final Widget? floatingActionButton;

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  ///
  late EdgeInsetsGeometry padding;

  ///
  Future? futureBuilderFuture;

  ///
  late Color backgroundColor;

  @override
  void initState() {
    padding = widget.padding ?? MyThemeData.instance.primaryPadding;
    backgroundColor = widget.backgroundColor ?? MyThemeData.instance.backgroundColor;
    futureBuilderFuture = reloadData();
    super.initState();
  }

  @protected
  Future reloadData() async {}

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = Scaffold(
      appBar: widget.appBar,
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      floatingActionButton: widget.floatingActionButton,
      body: FutureBuilder(
        future: futureBuilderFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          debugPrint('${snapshot.connectionState}');

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
                view = Container(
                  padding: padding,
                  height: double.infinity,
                  color: backgroundColor,
                  child: widget.body?.call(),
                );
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
