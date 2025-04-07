import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final String value;
  const TextWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title:    ',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,),
          ),
        ],
      ),
    );
  }
}
