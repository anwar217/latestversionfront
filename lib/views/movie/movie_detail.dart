import 'package:cinemamovie/models/movie.dart';
import 'package:cinemamovie/views/booking/widgets/booking_button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MovieDetail extends StatefulWidget {
  final Movie movieData;
  const MovieDetail({Key? key, required this.movieData}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  late VideoPlayerController _controller;
  bool vidInited = false;

  void initVideo() {
    if (!vidInited) {
      _controller = VideoPlayerController.network(widget.movieData.video)
        ..initialize().then((_) {
          _controller.play();
          _controller.setLooping(true);

          setState(() {
            vidInited = true;
          });
        });
    }
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  String _getFormattedTimeStart(dynamic projection) {
    if (projection is Map<String, dynamic> &&
        projection.containsKey('timestart')) {
      final String timestart = projection['timestart'];
      return timestart;
    }
    return '';
  }

  String _getFormattedTimeEnd(dynamic projection) {
    if (projection is Map<String, dynamic> &&
        projection.containsKey('timeend')) {
      final String timeend = projection['timeend'];
      return timeend;
    }
    return '';
  }

  String _getFormattedDate(dynamic projection) {
    if (projection is Map<String, dynamic> && projection.containsKey('date')) {
      final String date = projection['date'];
      final DateTime dateTime = DateTime.parse(date);
      final String formattedDate =
          '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
      return formattedDate;
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
@override
  Widget build(BuildContext context) {
    initVideo();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: (widget.movieData.title== null) ? Container() : Container(
        margin: const EdgeInsets.only(top: 30.0),
        child: WillPopScope(
          onWillPop: _onWillPop,

          child: Stack(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      (_controller.value.isPlaying ? _controller.pause() : _controller.play());
                    },

                    child: ClipRRect(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: (MediaQuery.of(context).size.width * 9) / 16,

                        child: _controller.value.isInitialized
                            ? AspectRatio(
                          aspectRatio: (16 / 9),
                          child: VideoPlayer(_controller),
                        ) : const Center(
                          child: SizedBox(
                            width: 100.0,
                            height: 100.0,

                            child: CircularProgressIndicator()
                          ),
                        ),
                      ),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10.0, 15.0, 0, 10.0),

                        child: const Text(
                          "Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                const Text(
                                  "Playing Date",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),

                                Text(
                                 _getFormattedDate(widget.movieData.listProjection![0]),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Time Start",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 220, 197, 197),
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),

                                  Text(
                                    _getFormattedTimeStart(widget.movieData.listProjection![0]),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),

                            Column(
                              children: [
                                const Text(
                                  "Time End",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),

                                Text(
                                  _getFormattedTimeEnd(widget.movieData.listProjection![0]),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: const Divider(
                          color: Colors.white,
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(10.0, 0, 0, 10.0),
                            child: const Text(
                              "Description",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            margin: const EdgeInsets.only(bottom: 15.0),

                            child: Text(
                               widget.movieData.description,
                              style: const TextStyle(color:  Colors.white),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.fromLTRB(10.0, 0, 0, 10.0),

                            child: Text(
                              (widget.movieData.imagesStars == null) ? "" : "Actors",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),

                          (widget.movieData.imagesStars == null) ? Container() : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const SizedBox(
                                  height: 150.0,
                                  width: 15.0,
                                ),
                                Row(
                                  children: widget.movieData.imagesStars.map<Widget>((actorUrl) =>
                                    Container(
                                      margin: const EdgeInsets.only(right: 15.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.0),

                                        child: SizedBox(
                                          width: 150.0,
                                          height: 150.0,
                                          child: Image.network(actorUrl, fit: BoxFit.cover, alignment: Alignment.center),
                                        ),
                                      ),
                                    ),
                                  ).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),

              Positioned(
                top: 5.0,
                left: 10.0,
                child: IconButton(
                  onPressed: () {
                    _controller.pause();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255,2,1,17),
                  height: 70.0,
                  width: MediaQuery.of(context).size.width,

                  child: Container(
                    width: 200.0,
                    height: 40.0,

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
                        //_controller.pause();
                        //Navigator.push(
                          //  context, MaterialPageRoute(builder: (context) => BookingScreen(movieData: widget.movieData)));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                        ),

                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),

                      child: const Text("Add To Cart "),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
