import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18.0),
      ),
    );
  }
}
