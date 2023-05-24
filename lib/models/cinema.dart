import 'package:cinemamovie/models/projection.dart';

class Cinema {
  final String id;
  final String name;
  final int? capacite;
  final String? dateCreation;
   final String? adress;
   final String? email;
   final String? tel;
  final String? description;
 final String? site;
 final String? urlLogo;
 
 

  Cinema({
    this.tel,
    this.email,
    this.capacite,
    this.dateCreation,
    required this.name,
    this.adress,
    required this.id,
    this.description,
    this.site,
    this.urlLogo,
  
  });

  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      name: json['name'].toString(),
      id: json['_id'].toString(),
    
      description: json['description'].toString(),
    
    
    );
  }
}