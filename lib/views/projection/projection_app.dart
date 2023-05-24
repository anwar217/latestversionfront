import 'package:cinemamovie/models/cinema.dart';
import 'package:cinemamovie/views/projection/cinema_button.dart';
import 'package:cinemamovie/views/projection/projection_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<List<Cinema>> getCinema() async {
    final response =
        await http.get(Uri.parse('http://192.168.100.57:5000/api/cinema'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Cinema>.from(
        jsonData.map(
          (cinema) => Cinema.fromJson(cinema),
        ),
      );
    } else {
      throw Exception('Failed to load cinemas');
    }
  }
}

class ProjectionApp extends StatefulWidget {
  const ProjectionApp({super.key});

  @override
  _ProjectionAppState createState() => _ProjectionAppState();
}

class _ProjectionAppState extends State<ProjectionApp> {
  // late Future<List<Category>> _categories;
  String _selectedCinema = '';

  @override
  void initState() {
    super.initState();
  }

  void _onCinemaPressed(String cinema) {
    setState(() {
      _selectedCinema = cinema;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          FutureBuilder<List<Cinema>>(
            future: ApiService.getCinema(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!.map((cinema) {
                        return CinemaButton(
                          onPressed: () => _onCinemaPressed(cinema.id),
                          isSelected: cinema.id == _selectedCinema,
                          text: cinema.name,
                        );
                      }).toList(),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const SizedBox(height: 40),
          Container(
            child: _selectedCinema.isEmpty
                ? const Text(
                    "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  )
                : ProjectionList(
                    cinemaId: _selectedCinema,
                  ),
          ),
        ],
      ),
    );
  }
}