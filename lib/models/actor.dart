import 'dart:convert';

class Actor {
  // Variables que contienen la información del actor
  int id;
  String name;
  String profilePath;// Ruta del perfil de imagen del actor
  String originalname;
  String knowdepartment;
  int gender;// Género del actor (1: femenino, 2: masculino, 0: no especificado)
  double popularity;

  // Constructor para inicializar los datos del actor
  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.originalname,
    required this.knowdepartment,
    required this.gender,
    required this.popularity,
  });

  
  factory Actor.fromMap(Map<String, dynamic> map) {// Método para crear un objeto Actor desde un mapa (ej. JSON)
    return Actor(
      id: map['id'] as int, 
      name: map['name'] ?? '', 
      profilePath: map['profile_path'] ?? '', 
      originalname: map['original_name'] ?? '', 
      knowdepartment: map['known_for_department'] ?? '', 
      gender: map['gender'] ?? '', 
      popularity: map['popularity']?.toDouble() ?? 0.0, 
    );
  }

  // Método para crear un objeto Actor desde una cadena JSON
  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));
}
