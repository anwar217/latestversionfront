import 'package:flutter/material.dart';

class PressedButton extends StatelessWidget {
  const PressedButton({
    super.key,
    required this.list,
  });

  final Widget list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: list,
      ),
    );
  }
}
