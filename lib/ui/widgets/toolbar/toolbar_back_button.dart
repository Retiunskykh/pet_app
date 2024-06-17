import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

class ToolbarBackButton extends StatelessWidget {
  final Function()? onPressedAction;

  const ToolbarBackButton({
    this.onPressedAction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      opacityMinValue: 0.2,
      duration: const Duration(milliseconds: 1000),
      scaleMinValue: 0.8,
      onPressed: () {
        if (onPressedAction == null) {
          Navigator.pop(context);
        } else {
          onPressedAction!();
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin:  const EdgeInsets.only(left: 12),
        width: 48,
        height: 48,
        child: const Icon(
          Icons.arrow_back_ios,
          size: 32,
          color: Colors.black,
        ),
      ),
    );
  }
}
