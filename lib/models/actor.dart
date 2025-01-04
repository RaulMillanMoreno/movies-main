import 'dart:convert';

class Actor {// se cambian las diferentes variables para que se obtengan los datos de los actores.
  int id;
  String name;
  String profilePath;
  String originalname;
  String knowdepartment;
  int gender;
  double popularity;
  // List<int> genreIds;
  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.originalname,
    required this.knowdepartment, // era el overview
    required this.gender,
    required this.popularity,
    // required this.genreIds,
  });

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'] as int,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      originalname: map['original_name'] ?? '',
      knowdepartment: map['known_for_department'] ?? '', // era el overview.
      gender: map['gender'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      // genreIds: List<int>.from(map['genre_ids']),
    );
  }

  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));
}
