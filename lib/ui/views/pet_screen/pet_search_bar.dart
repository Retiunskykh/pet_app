import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PetSearchBar extends StatelessWidget {
  final double height;
  final Function(String) onSearchButtonTap;
  final TextEditingController textEditingController = TextEditingController();

  PetSearchBar({
    super.key,
    required this.height,
    required this.onSearchButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              textAlign: TextAlign.left,
              cursorColor: const Color(0xFF03063A),
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0xFFCAC9C9),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                border: InputBorder.none,
              ),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color(0xFF03063A),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onSearchButtonTap(textEditingController.text),
            child: Container(
              height: height,
              width: height,
              decoration: BoxDecoration(
                color: const Color(0xFF827397),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
