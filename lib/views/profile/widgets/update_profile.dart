import 'dart:convert';
import 'package:cinemamovie/models/user.dart';
import 'package:cinemamovie/widgets/app_top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  User user = User('', '', '', '');

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final storage = FlutterSecureStorage();
    final userData = await storage.read(key: "userData");
    if (userData != null) {
      setState(() {
        user;
      });
    }
  }

  Future<void> updateProfile(BuildContext context, User user) async {
    final formKey = GlobalKey<FormState>();
    if (formKey.currentState!.validate()) {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      final headers = {"Authorization": "Bearer $token"};
      final userData = await storage.read(key: "userData");

      if (userData != null) {
        final decodedData = jsonDecode(userData);
        final userJson = user.toJson();
        final updatedUserData = <String, dynamic>{...decodedData, ...userJson};
        final body = jsonEncode(updatedUserData);
        final response = await http.put(
            Uri.parse("http://192.168.1.26:5000/api/"),
            headers: headers,
            body: body);

        if (response.statusCode == 200) {
          await storage.write(key: "userData", value: body);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Profile updated successfully!'),
          ));
        } else {
          // erreur lors de l'appel à l'API, vous pouvez afficher un message d'erreur à l'utilisateur
          debugPrint("Erreur lors de la mise à jour du profil");
        }
      }
    }
  }

  bool _obscured = false;
  final textFieldFocusNode = FocusNode();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      }
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2b2a3a),
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
            const Spacer(),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppTop(
                logoImage: 'images/logo.png',
                label: "UpdateProfile",
              ),
              const SizedBox(height: 50),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                initialValue: user.userName,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 255, 213, 0),
                  ),
                  hintText: "Name",
                  hintStyle:
                      const TextStyle(fontSize: 20.0, color: Colors.white),
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    user.userName = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                initialValue: user.email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add more email validation if needed
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    user.email = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: Color.fromARGB(255, 255, 213, 0),
                  ),
                  hintText: "Email",
                  hintStyle:
                      const TextStyle(fontSize: 20.0, color: Colors.white),
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
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                initialValue: user.password,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleObscured,
                    child: Icon(
                      _obscured
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: const Color.fromARGB(255, 255, 213, 0),
                      size: 24,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.vpn_key,
                    color: Color.fromARGB(255, 255, 213, 0),
                  ),
                  hintText: "Enter your new password",
                  hintStyle:
                      const TextStyle(fontSize: 20.0, color: Colors.white),
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your New Password';
                  }
                  // Add more phone number validation if needed
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    user.password = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint(' $updateProfile');
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 246, 189, 0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: const BorderSide(
                          color: Color.fromRGBO(255, 213, 0, 1),
                        ),
                      ),
                    ),
                  ),
                  child: const Text('Update Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
