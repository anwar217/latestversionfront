class TimeElement {
  final int hour;
  final int minute;

  TimeElement({
    required this.hour,
    required this.minute,
  });

  factory TimeElement.fromJson(Map<String, dynamic> json) {
    return TimeElement(
      hour: json['hour'],
      minute: json['minute'],
    );
  }
}

class Movie {
  final String id;
  final String title;
  final String category;
  final String description;
  final String? partner;
  final int age;
  final String type;
  final String image;
  final String video;
  final List<String> imagesStars;
  final List<dynamic>? listProjection;
  final TimeElement? timestamps;

  Movie({
    required this.title,
    required this.timestamps,
    required this.category,
    required this.id,
    required this.description,
    this.partner,
    required this.age,
    required this.type,
    required this.image,
    required this.video,
    required this.imagesStars,
    this.listProjection,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'].toString(),
      id: json['_id'].toString(),
      category: json['category'].toString(),
      age: json['age'],
      type: json['type'].toString(),
      description: json['description'].toString(),
      image: json['image'].toString(),
      partner: json['partner'] != null ? json['partner'].toString() : null,
      timestamps: json['timestamps'] != null
          ? TimeElement.fromJson(json['timestamps'])
          : null,
      imagesStars: List<String>.from(json['imagesStars']),
      video: json['video'].toString(),
      listProjection: json['listProjection'] != null
          ? List<dynamic>.from(json['listProjection'])
          : null,
    );
  }
}

String _getFormattedTimeStart(dynamic projection) {
  if (projection is Map<String, dynamic> && projection.containsKey('timestart')) {
    final String timestart = projection['timestart'];
    final List<String> timeComponents = timestart.split(':');
    if (timeComponents.length == 2) {
      final String hour = timeComponents[0].padLeft(2, '0');
      final String minute = timeComponents[1].padLeft(2, '0');
      return '$hour:$minute';
    }
  }
  return '';
}
