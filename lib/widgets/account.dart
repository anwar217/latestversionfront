import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  final void Function() onTap;
  final String textAccount;
  final String label;
  const Account({
    super.key,
    required this.onTap,
    required this.textAccount,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            textAccount,
            style: const TextStyle(
                color: Color.fromARGB(255, 255, 213, 0),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
