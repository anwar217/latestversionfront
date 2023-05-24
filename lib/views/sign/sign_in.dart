import 'package:cinemamovie/views/sign/sign_up.dart';
import 'package:cinemamovie/views/home/home_page.dart';
import 'package:cinemamovie/models/user.dart';
import 'package:cinemamovie/widgets/account.dart';
import 'package:cinemamovie/widgets/app_top.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  Future save() async {
    var res = await post(
        Uri.parse("http://192.168.100.57:5000/api/users/login"),
        headers: {"Content-type": "application/json"},
        body: jsonEncode({'email': user.email, 'password': user.password}));

    if (jsonDecode(res.body)["message"] == null) {
      const storage = FlutterSecureStorage();
      await storage.write(key: "userData", value: res.body);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  User user = User('', '', '', '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 90),
              const AppTop(
                logoImage: 'images/logo.png',
                label: "SignIn",
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: TextEditingController(text: user.email),
                  onChanged: (value) {
                    user.email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter something';
                    } else if (RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return null;
                    } else {
                      return 'Enter valid email';
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email,
                          color: Color.fromARGB(255, 255, 213, 0)),
                      hintText: 'Enter Email',
                      hintStyle:
                          const TextStyle(fontSize: 20.0, color: Colors.white),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: TextEditingController(text: user.password),
                  onChanged: (value) {
                    user.password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter something';
                    }
                    return null;
                  },
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.vpn_key,
                        color: Color.fromARGB(255, 255, 213, 0),
                      ),
                      hintText: 'Enter Password',
                      hintStyle:
                          const TextStyle(fontSize: 20.0, color: Colors.white),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(55, 16, 16, 0),
                child: SizedBox(
                  height: 50,
                  width: 400,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 246, 189, 0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        save();
                      } else {
                        debugPrint("not ok");
                      }
                    },
                    child: const Text(
                      "SignIn",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Account(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                label: 'You dont have an account ?',
                textAccount: 'SignUp',
              ),
            ],
          ),
        )
      ],
    )));
  }
}
