import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTop extends StatelessWidget {
  final String logoImage;
  final String label;
  const AppTop({super.key, required this.logoImage, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: 300,
          child: Image.asset(
            logoImage,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.pacifico(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: const Color.fromARGB(255, 255, 213, 0),
          ),
        ),
      ],
    );
  }
}
