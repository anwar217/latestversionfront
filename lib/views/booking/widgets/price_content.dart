import 'package:flutter/material.dart';

class PriceContent extends StatelessWidget {
  const PriceContent({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          const Text(
            "Total Price",
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w500),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            margin: const EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              children: [
                const Icon(
                  Icons.star_rate,
                  color: Color(0xFFD2BE07),
                ),
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
