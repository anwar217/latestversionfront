import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String category;
  final VoidCallback onPressed;
  final bool isSelected;

  const CategoryButton({
    required this.category,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? Colors.yellow // Change the button color if it's selected
              : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        child: Text(
          category,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
