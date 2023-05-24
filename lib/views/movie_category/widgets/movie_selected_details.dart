import 'package:cinemamovie/models/movie.dart';
import 'package:cinemamovie/views/booking/booking.dart';
import 'package:flutter/material.dart';

class MovieSelectedDetails extends StatelessWidget {
  const MovieSelectedDetails({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: (MediaQuery.of(context).size.width - 50.0),
      height: MediaQuery.of(context).size.height * .2,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2b2a3a),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: Image.network(
                  movie.image,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                Spacer(),
                /*if (movie.listProjection != null && movie.listProjection!.isNotEmpty)
                  Text(
                    'Time Start: ${_getFormattedDate(movie.listProjection![0])}',
                    style: const TextStyle(color: Colors.white),
                  ),
                Spacer(),*/
                Text(
                  'Since: ${movie.age} years',
                  style: const TextStyle(color: Colors.white),
                ),
                Spacer(),
                Text(
                  movie.type,
                  style: const TextStyle(color: Colors.white),
                ),
                Spacer(flex: 4),
                Container(
                  height: 35.0,
                  margin: const EdgeInsets.only(bottom: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xfff64c18), Color(0xffff8a1b)],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Booking(
                            movieData: movie,
                            movie: movie,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      primary: Colors.transparent,
                      onSurface: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text("Book A Ticket"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getFormattedTimeStart(dynamic projection) {
    if (projection is Map<String, dynamic> && projection.containsKey('timestart')) {
      final String timestart = projection['timestart'];
      return timestart;
    }
    return '';
  }
   String _getFormattedDate(dynamic projection) {
    if (projection is Map<String, dynamic> && projection.containsKey('date')) {
      final String date = projection['date'];
      final DateTime dateTime = DateTime.parse(date);
      final String formattedDate = '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
      return formattedDate;
    }
    return '';
  }
}
