import 'package:cinemamovie/views/sign/sign_in.dart';
import 'package:cinemamovie/models/user.dart';
import 'package:cinemamovie/widgets/account.dart';
import 'package:cinemamovie/views/sign/widgets/button_sign.dart';
import 'package:cinemamovie/views/sign/widgets/pic_detector.dart';
import 'package:cinemamovie/widgets/app_top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final _formKey = GlobalKey<FormState>();
  Future save(String url) async {
    var baseURL = dotenv.env['BASE_URL'];
    debugPrint("$baseURL");
    var res = await post(
      Uri.parse("http://192.168.100.57:5000/api/users/"),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(
        {
          'email': user.email,
          'password': user.password,
          'userName': user.userName,
          'image': url
        },
      ),
    );

    debugPrint(jsonDecode(res.body)["message"]);

    if (jsonDecode(res.body)["message"] == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignIn(),
        ),
      );
    }
  }

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) {
      save("");
      return;
    }
    ;
    final fileName = path.basename(_photo!.path);

    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(fileName);
      await ref.putFile(_photo!);

      String url = (await ref.getDownloadURL()).toString();
      save(url);
    } catch (e) {
      debugPrint('error occured');
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 90),
                    const AppTop(
                      logoImage: 'images/logo.png',
                      label: "SignUp",
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: const Color(0xffFDCF09),
                        child: _photo != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _photo!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : const PicDetecotor(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: TextEditingController(text: user.userName),
                        onChanged: (value) {
                          user.userName = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter something';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 255, 213, 0),
                          ),
                          hintText: "Enter username",
                          hintStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.white),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: TextEditingController(text: user.email),
                        onChanged: (value) {
                          user.email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter something';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 255, 213, 0),
                          ),
                          hintText: "Enter your Email",
                          hintStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.white),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
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
                        decoration: InputDecoration(
                          icon: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 255, 213, 0),
                          ),
                          hintText: "Enter your password",
                          hintStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.white),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(55, 16, 16, 0),
                      child: ButtonSign(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            uploadFile();
                          } else {
                            debugPrint("not ok");
                          }
                        },
                        buttonText: 'SignUp',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(95, 20, 0, 0),
                      child: Account(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()));
                        },
                        textAccount: 'SignIn',
                        label: 'Already have Account ? ',
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
