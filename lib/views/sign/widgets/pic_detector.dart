import 'package:flutter/material.dart';

class PicDetecotor extends StatelessWidget {
  const PicDetecotor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(50)),
      width: 100,
      height: 100,
      child: Icon(
        Icons.camera_alt,
        color: Colors.grey[800],
      ),
    );
  }
}
