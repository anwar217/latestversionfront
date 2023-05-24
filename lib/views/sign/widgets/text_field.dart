import 'package:cinemamovie/models/user.dart';
import 'package:flutter/material.dart';

class TextFieldEnter extends StatefulWidget {
  final String hintText;
  final void Function(String)? onChange;
  const TextFieldEnter({
    super.key,
    required this.hintText,
     this.onChange,
  });

  @override
  State<TextFieldEnter> createState() => _TextFieldEnterState();
}

class _TextFieldEnterState extends State<TextFieldEnter> {
  @override
  Widget build(BuildContext context) {
    User user = User('', '', '', '');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        decoration: InputDecoration(
          icon: const Icon(
            Icons.person,
            color: Color.fromARGB(255, 255, 213, 0),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 213, 0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 213, 0),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 213, 0),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 213, 0),
            ),
          ),
        ),
        style: const TextStyle(color: Colors.white),
        controller: TextEditingController(text: user.userName),
        onChanged: widget.onChange,
      ),
    );
  }
}
