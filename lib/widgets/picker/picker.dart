import 'package:count_down/style/theme_data.dart';
import 'package:count_down/widgets/picker/flat_scroll_wheel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';

///
class MyPickerWidget extends StatefulWidget {
  const MyPickerWidget({
    super.key,
    required this.items1,
    required this.items2,
    required this.onChanged,
    this.looping = true,
  });

  ///
  final List<String> items1;

  ///
  final List<String> items2;

  ///
  final ValueChanged<List<String>> onChanged;

  ///
  final bool looping;

  @override
  State<MyPickerWidget> createState() => _MyPickerWidgetState();
}

class _MyPickerWidgetState extends State<MyPickerWidget> {
  ///
  late ScrollWheelDatePickerTheme theme;

  ///
  late String _selectedItem1;

  ///
  late String _selectedItem2;

  @override
  void initState() {
    theme = FlatDatePickerTheme(
      backgroundColor: MyThemeData.instance.backgroundColor,
      overlay: ScrollWheelDatePickerOverlay.highlight,
      itemTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
      overlayColor: Color(0xFFC6DEFF),
      overAndUnderCenterOpacity: 0.4,
    );

    _selectedItem1 = widget.items1.first;
    _selectedItem2 = widget.items2.first;
    super.initState();
  }

  ///
  void _onSelectedItemChanged() {
    widget.onChanged.call([_selectedItem1, _selectedItem2]);
  }

  ///
  Widget _scrollWidget({
    required List<String> items,
    Function(int value)? controllerItemChanged,
  }) {
    return FlatScrollWheel(
      items: items,
      selectedIndex: 0,
      onSelectedItemChanged: controllerItemChanged,
      looping: widget.looping,
      itemExtent: theme.itemExtent,
      textStyle: theme.itemTextStyle,
      listenAfterAnimation: true,
    );
  }

  ///
  Widget _overlay() {
    return HightlightOverlay(
      height: theme.itemExtent,
      color: theme.overlayColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _overlay(),
        SizedBox(
          height: theme.wheelPickerHeight,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: theme.fadeEdges
                    ? [
                        Colors.black,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black
                      ]
                    : [Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: theme.fadeEdges ? [0.0, 0.08, 0.92, 1.0] : [0.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstOut,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _scrollWidget(
                    controllerItemChanged: (value) {
                      _selectedItem1 = widget.items1[value];
                      _onSelectedItemChanged();
                    },
                    items: widget.items1,
                  ),
                ),
                Expanded(
                  child: _scrollWidget(
                    controllerItemChanged: (value) {
                      _selectedItem2 = widget.items2[value];
                      _onSelectedItemChanged();
                    },
                    items: widget.items2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HightlightOverlay extends StatelessWidget {
  /// Creates a rounded rectangle background with the default [CupertinoContextMenu.kOpenBorderRadius] radius.
  const HightlightOverlay({
    super.key,
    required this.height,
    this.color,
  });

  /// Actual height of the [HightlightOverlay].
  final double height;

  /// Background color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.withOpacity(0.1),
        borderRadius:
            BorderRadius.circular(CupertinoContextMenu.kOpenBorderRadius),
      ),
    );
  }
}
