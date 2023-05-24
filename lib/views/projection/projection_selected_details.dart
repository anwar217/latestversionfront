import 'package:cinemamovie/models/projection.dart';
import 'package:cinemamovie/views/projection/cinema_button.dart';
import 'package:cinemamovie/views/projection/projection_list.dart';
import 'package:flutter/material.dart';

class ProjectionsSelectedDetails extends StatefulWidget {
  const ProjectionsSelectedDetails({
    super.key,
    required this.projection,
  });

  final Projection projection;

  @override
  State<ProjectionsSelectedDetails> createState() =>
      _ProjectionsSelectedDetailsState();
}

class _ProjectionsSelectedDetailsState
    extends State<ProjectionsSelectedDetails> {
  String _selectedProjection = "";

  @override
  void initState() {
    super.initState();
  }

  void _onProjectionPressed(String prix) {
    setState(() {
      _selectedProjection = prix;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CinemaButton(
            text: widget.projection.dateProjection.hour.toString(),
            onPressed: () => _onProjectionPressed(widget.projection.id),
            isSelected: widget.projection.id == _selectedProjection,
          ),
          Container(
            child: _selectedProjection.isEmpty
                ? const Text(
                    "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  )
                : CinemaButton(
                    text: '${widget.projection.prix} TND', onPressed: () {}),
          ),
        ],
      ),
    );
  }
}