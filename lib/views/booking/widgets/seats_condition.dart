import 'package:flutter/material.dart';

class SeatsCondition extends StatelessWidget {
  const SeatsCondition({
    super.key,
    required this.conditionText,
    required this.iconColor,
  });
  final String conditionText;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: iconColor,
          ),
          Text(
            conditionText,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
