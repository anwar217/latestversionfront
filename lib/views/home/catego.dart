import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Category> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  Future<void> _getCategories() async {
    try {
      final response =
          await http.get(Uri.parse('http://monapi.com/categories'));

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        final List<dynamic> jsonCategories = jsonBody['categories'];
        setState(() {
          _categories = jsonCategories
              .map((jsonCategory) => Category.fromJson(jsonCategory))
              .toList();
          _isLoading = false;
        });
      } else {
        print('Error retrieving categories');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Error retrieving categories: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                final category = _categories[index];
                return ListTile(
                  title: Text(category.name),
                  subtitle: Text(category.id),
                );
              },
            ),
    );
  }
}
