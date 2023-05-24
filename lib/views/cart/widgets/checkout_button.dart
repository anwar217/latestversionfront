import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 40.0,
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: const Color(0xffd3be01)),
        child: const Text(
          "Check Out",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16.0),
        ),
      ),
    );
  }
}
