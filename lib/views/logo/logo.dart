import 'package:cinemamovie/views/sign/sign_in.dart';
import 'package:cinemamovie/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Logo extends StatefulWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  void checkUserSignIn() async {
    const storage = FlutterSecureStorage();
    var existingData = await storage.read(key: "userData");

    Future.delayed(const Duration(seconds: 2), () {
      if (existingData != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NavBar(),
          ),
        );
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            ));
      }
    });
  }

  @override
  void initState() {
    checkUserSignIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Image.asset('images/logo.png'),
        ),
      ),
    );
  }
}
