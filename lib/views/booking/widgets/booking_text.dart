import 'package:flutter/material.dart';

class BookingText extends StatelessWidget {
  const BookingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      child: const Text(
        "Select Location, Date and Time",
        style: TextStyle(color: Colors.white, fontSize: 17.0),
      ),
    );
  }
}
