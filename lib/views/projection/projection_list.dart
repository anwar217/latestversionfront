import 'dart:convert';

import 'package:cinemamovie/models/projection.dart';
import 'package:cinemamovie/views/projection/projection_selected_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Projection>> getProjectionByIdSalle(
      String cinemaId) async {
    print('cinemaId: $cinemaId');
    final response = await http.get(Uri.parse(
        'http://192.168.1.26:5000/api/projections/getProjectionByIdSalle/$cinemaId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Projection>.from(jsonData.map(
        (projection) => Projection.fromJson(projection),
      ));
    } else {
      throw Exception('Failed to load projections');
    }
  }
}

class ProjectionList extends StatefulWidget {
  final String cinemaId;

  const ProjectionList({
    Key? key,
    required this.cinemaId,
  }) : super(key: key);

  @override
  State<ProjectionList> createState() => _ProjectionListState();
}

class _ProjectionListState extends State<ProjectionList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Projection>>(
      future: ApiService.getProjectionByIdSalle(
        widget.cinemaId,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Projection> filteredProjections = snapshot.data!;
          return Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: filteredProjections.length,
              itemBuilder: (context, index) {
                final projection = filteredProjections[index];
                return Column(
                  children: [
                    ProjectionsSelectedDetails(
                      projection: projection,
                    ),
                  ],
                );
              },
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
