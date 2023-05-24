import 'package:cinemamovie/views/cart/widgets/checkout_button.dart';
import 'package:flutter/material.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({
    super.key,
    required this.priceText,
  });
  final String priceText;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 2, 1, 17),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    priceText,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            const CheckoutButton(),
          ],
        ),
      ),
    );
  }
}
