class Projection {
  final DateTime dateProjection;
  final double prix;
  final String id;
  final String name;
  final String cinemaId;


  Projection({
    required this.id,
    required this.name,
    required this.prix,
    required this.dateProjection,
    required this.cinemaId,

  });

  factory Projection.fromJson(Map<String, dynamic> json) {
    return Projection(
      id: json['_id'].toString(),
      name: json['name'].toString(),
      cinemaId: json['cinemaId'].toString(),
      dateProjection: DateTime.parse(json['dateProjection']),
      prix: json['prix'],
    );
  }
}