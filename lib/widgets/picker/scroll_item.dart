import 'package:flutter/material.dart';


class ScrollItem extends StatelessWidget {
  /// Item of a [ScrollWheelDatePicker] type.
  ///
  /// [label] Label of the [ScrollWheelDatePicker] countdown.
  ///
  /// [textStyle] Text style of the [ScrollWheelDatePicker] countdown.
  const ScrollItem({
    super.key,
    required this.label,
    this.textStyle,
  });

  /// Label of the [ScrollWheelDatePicker] countdown.
  final String label;

  /// Text style of the [ScrollWheelDatePicker] countdown.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          label,
          style: textStyle,
        ),
      ),
    );
  }
}
