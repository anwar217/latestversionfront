import 'package:flutter/material.dart';

class BookingButton extends StatelessWidget {

  final VoidCallback onPressed;
  const BookingButton({
    super.key,
 required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 40.0,
      margin: const EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xfff64c18), Color(0xffff8a1b)],
          stops: [0.0, 1.0],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          primary: Colors.transparent,
          onSurface: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: const Text("Book A Ticket"),
      ),
    );
  }
}
