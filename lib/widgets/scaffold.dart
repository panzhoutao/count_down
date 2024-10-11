import 'package:count_down/style/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

///
class MyScaffold extends StatefulWidget {
  MyScaffold({
    super.key,
    this.appBar,
    EdgeInsetsGeometry? padding,
    this.body,
    this.backgroundColor,
  }) {
    padding ??= MyThemeData.instance.primaryPadding;
  }

  final PreferredSizeWidget? appBar;

  final Widget Function()? body;

  final Color? backgroundColor;

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {

  final EdgeInsetsGeometry? padding;

  Future? futureBuilderFuture;

  @override
  Widget build(BuildContext context) {

    Scaffold scaffold = Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
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
                view = Padding(padding: padding!, child: widget.body?.call());
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
