import 'package:cinemamovie/views/sign/sign_up.dart';
import 'package:cinemamovie/views/home/home_page.dart';
import 'package:cinemamovie/models/user.dart';
import 'package:cinemamovie/views/sign/widgets/button_sign.dart';
import 'package:cinemamovie/views/success.dart';
import 'package:cinemamovie/widgets/account.dart';
import 'package:cinemamovie/widgets/app_top.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2b2a3a),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.add_card,
                              color: Color.fromARGB(255, 255, 213, 0)),
                          hintText: 'Enter your card number',
                          hintStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 213, 0))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 213, 0))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 213, 0))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 213, 0)))),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.vpn_key,
                            color: Color.fromARGB(255, 255, 213, 0),
                          ),
                          hintText: 'Card Holder',
                          hintStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 213, 0))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 213, 0))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 213, 0))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 213, 0)))),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    Icons.calendar_month_rounded,
                                    color: Color.fromARGB(255, 255, 213, 0)),
                                hintText: 'Expiration',
                                hintStyle: const TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 213, 0))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 213, 0))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 213, 0))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 213, 0)))),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    Icons.private_connectivity_sharp,
                                    color: Color.fromARGB(255, 255, 213, 0)),
                                hintText: 'CCV',
                                hintStyle: const TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 213, 0))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 213, 0))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 213, 0))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 255, 213, 0)))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ButtonSign(buttonText: 'Pay', onPressed: () { 
 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Success(),
                                    ),
                                  );
                   },)
                ],

              ),
            )
          ],
        ),
      ),
    );
  }
}
