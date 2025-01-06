import 'dart:convert';

class DescActor {// se cambian las diferentes variables para que se obtengan los datos de los actores.
  int id;
  String name;
  String profilePath;
  String birthday;
  String knowdepartment;
  String place_of_birth;
  double popularity;
  String biography;
  // List<int> genreIds;
  DescActor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.birthday,
    required this.knowdepartment, // era el overview
    required this.place_of_birth,
    required this.popularity,
    required this.biography,
    // required this.genreIds,
  });

  factory DescActor.fromMap(Map<String, dynamic> map) {
    return DescActor(
      id: map['id'] as int,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      birthday: map['birthday'] ?? '',
      knowdepartment: map['known_for_department'] ?? '', // era el overview.
      place_of_birth: map['place_of_birth'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      biography: map['biography'] ?? '',
      // genreIds: List<int>.from(map['genre_ids']),
    );
  }

  factory DescActor.fromJson(String source) => DescActor.fromMap(json.decode(source));
}
