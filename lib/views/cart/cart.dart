import 'package:cinemamovie/views/booking/widgets/movie_details.dart';
import 'package:cinemamovie/views/cart/widgets/total_price.dart';
import 'package:cinemamovie/views/payment.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var cartMovies = [];
  void getMovies() async {
    const storage = FlutterSecureStorage();
    String? cartData = await storage.read(key: "cartData");

    setState(() {
      cartMovies = jsonDecode(cartData!);
    });
  }

  num calcPrice() {
    num price = 0;

    for (var movie in cartMovies) {
      price += (movie["seats"].length) * movie["price"];
    }

    return price;
  }

  @override
  void initState() {
    getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'My Cart',
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
      body: Stack(
        children: [
          Positioned(
            top: 10.0,
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height - 200.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: cartMovies
                  .map(
                    (movie) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Payment(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: (MediaQuery.of(context).size.width - 50.0),
                        height: 230.0,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        margin: const EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2b2a3a),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  width: 130.0,
                                  height: 200.0,
                                  child: Image.network(movie["image"],
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MovieDetails(
                                    text: movie["title"],
                                  ),
                                  MovieDetails(
                                    text: movie["type"],
                                  ),
                                 
                                  MovieDetails(
                                    text: "${movie["listProjection"][0]["prix"].toString()} DT",
                                  ),
                                  MovieDetails(
                                      text:
                                          " Your place is ${movie["seats"].length.toString()} "),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          TotalPrice(
            priceText: "${calcPrice()} dt",
          ),
        ],
      ),
    );
  }
}