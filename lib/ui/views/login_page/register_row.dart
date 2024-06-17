import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterRow extends StatelessWidget {
  final IconData? icon;
  final TextEditingController textEditingController;
  final String title;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? value;
  final Function? onPressedAction;

  RegisterRow({
    required this.textEditingController,
    required this.title,
    required this.keyboardType,
    required this.obscureText,
    this.icon,
    this.value,
    this.onPressedAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      alignment: Alignment.center,
      height: 48,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              obscureText: obscureText,
              keyboardType: keyboardType,
              textAlign: TextAlign.left,
              cursorColor: Colors.black,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                hintText: title,
                hintStyle: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                contentPadding: const EdgeInsets.only(bottom: 16),
                border: InputBorder.none,
              ),
              style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 48,
            height: 48,
            child: ScaleTap(
              onPressed: () {
                if (onPressedAction != null) {
                  onPressedAction!();
                }
              },
              child: Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
            ),
          )
        ],
      ),
    );
  }
}
