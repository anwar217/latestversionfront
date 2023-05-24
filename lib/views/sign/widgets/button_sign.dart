import 'package:flutter/material.dart';

class ButtonSign extends StatefulWidget {
  final void Function() onPressed;
  final String buttonText;
  const ButtonSign(
      {super.key, required this.onPressed, required this.buttonText});

  @override
  State<ButtonSign> createState() => _ButtonSignState();
}

class _ButtonSignState extends State<ButtonSign> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 400,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(255, 246, 189, 0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: const BorderSide(
                color: Color.fromRGBO(255, 213, 0, 1),
              ),
            ),
          ),
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.buttonText,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
