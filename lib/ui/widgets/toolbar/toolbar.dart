import 'package:adopt_a_pet/ui/widgets/text/h2_text.dart';
import 'package:adopt_a_pet/ui/widgets/toolbar/toolbar_back_button.dart';
import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget {
  final String title;
  final bool withBackButton;
  final Function()? onBackPressedAction;

  const Toolbar({
    required this.title,
    this.withBackButton = true,
    this.onBackPressedAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          withBackButton
              ? ToolbarBackButton(
                  onPressedAction: onBackPressedAction,
                )
              : Container(),
          Expanded(child: Container()),
          H2Text(
            text: title,
            textColor: Colors.black,
            textAlign: TextAlign.center,
          ),
          Expanded(child: Container()),
          withBackButton ? const SizedBox(width: 60) : Container(),
        ],
      ),
    );
  }
}
