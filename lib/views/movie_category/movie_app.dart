import 'package:cinemamovie/models/category.dart';
import 'package:cinemamovie/models/movie.dart';
import 'package:cinemamovie/views/movie/movie_detail.dart';
import 'package:cinemamovie/views/movie_category/movie_list.dart';
import 'package:cinemamovie/views/movie_category/widgets/category_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'widgets/movie_selected_details.dart';

class ApiService {
  static Future<List<Movie>> getMovies() async {
    final response = await http.get(Uri.parse('http://192.168.1.26:5000/api/film'));
    print("${json.decode(response.body)}");
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Movie>.from(jsonData.map((movie) => Movie.fromJson(movie)));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('http://192.168.1.26:5000/api/categorie'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Category>.from(jsonData.map((category) => Category.fromJson(category)));
    } else {
      throw Exception('Failed to load categories');
    }
  }
}

class MovieApp extends StatefulWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  String _selectedCategory = 'all'; // Set the initial selected category to 'all'
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  void _onCategoryPressed(String category) {
    setState(() {
      _selectedCategory = category;
      _searchQuery = ''; // Reset search query when a category is selected
    });
  }

  void _onSearchQueryChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void _onMovieSelected(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetail(movieData: movie)),
    );
  }

  bool _isMovieMatch(Movie movie) {
    final lowercaseQuery = _searchQuery.toLowerCase();
    final lowercaseTitle = movie.title.toLowerCase();
    return lowercaseTitle.contains(lowercaseQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(7.5),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF292B37),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: _onSearchQueryChanged,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search for a movie',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<Category>>(
              future: ApiService.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // Add the 'All' button at the beginning
                        CategoryButton(
                          category: 'All',
                          onPressed: () => _onCategoryPressed('all'),
                          isSelected: _selectedCategory == 'all',
                        ),
                        ...snapshot.data!.map((category) {
                          return CategoryButton(
                            category: category.name,
                            onPressed: () => _onCategoryPressed(category.id),
                            isSelected: category.id == _selectedCategory,
                          );
                        }).toList(),
                      ],
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
              child: _selectedCategory == 'all' // Check if 'all' category is selected
                  ? FutureBuilder<List<Movie>>(
                      future: ApiService.getMovies(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                          final List<Movie> movies = snapshot.data!;
                          final filteredMovies = _searchQuery.isEmpty
                              ? movies // No search query, show all movies
                              : movies.where(_isMovieMatch).toList();
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredMovies.length,
                            itemBuilder: (context, index) {
                              final movie = filteredMovies[index];
                              return GestureDetector(
                                onTap: () => _onMovieSelected(movie),
                                child: MovieSelectedDetails(movie: movie),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    )
                  : MovieList(category: _selectedCategory, searchQuery: _searchQuery),
            ),
          ],
        ),
      ),
    );
  }
}
