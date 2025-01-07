import 'dart:convert';

class DescActor {
  // Variables que contienen la información detallada del actor
  int id; 
  String name; 
  String profilePath;// Ruta del perfil de imagen del actor
  String birthday; 
  String knowdepartment; 
  String place_of_birth; 
  double popularity;
  String biography;

  // Constructor para inicializar los datos del actor detallado
  DescActor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.birthday,
    required this.knowdepartment,
    required this.place_of_birth,
    required this.popularity,
    required this.biography,
  });

  // Método para crear un objeto DescActor desde un mapa (ej. JSON)
  factory DescActor.fromMap(Map<String, dynamic> map) {
    return DescActor(
      id: map['id'] as int, 
      name: map['name'] ?? '', 
      profilePath: map['profile_path'] ?? '', 
      birthday: map['birthday'] ?? '', 
      knowdepartment: map['known_for_department'] ?? '', 
      place_of_birth: map['place_of_birth'] ?? '', 
      popularity: map['popularity']?.toDouble() ?? 0.0,
      biography: map['biography'] ?? '',
    );
  }

  // Método para crear un objeto DescActor desde una cadena JSON
  factory DescActor.fromJson(String source) => DescActor.fromMap(json.decode(source));
}
