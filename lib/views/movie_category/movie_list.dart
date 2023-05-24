import 'dart:convert';
import 'package:cinemamovie/models/movie.dart';
import 'package:cinemamovie/views/movie_category/widgets/movie_selected_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Movie>> getMoviesByCategory(String category) async {
    print(category);
    final response = await http.get(
        Uri.parse('http://192.168.1.26:5000/api/film/categorie/$category'));
    print("${json.decode(response.body)}");
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Movie>.from(jsonData.map((movie) => Movie.fromJson(movie)));
    } else {
      throw Exception('Failed to load movies');
    }
  }
}

class MovieList extends StatefulWidget {
  final String category;

  const MovieList({Key? key, required this.category, required String searchQuery}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: ApiService.getMoviesByCategory(widget.category),
      
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Movie> filteredMovies = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = filteredMovies[index];
                      return Column(
                        children: [
                          MovieSelectedDetails(movie: movie),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const Text("Erreur");
        }
      },
    );
  }
}
