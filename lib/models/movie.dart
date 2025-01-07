import 'dart:convert';

class Movie {
  // Variables que contienen la información básica de la película
  int id; 
  String title; 
  String posterPath; // Ruta de la imagen del cartel (poster) de la película
  String backdropPath; // Ruta de la imagen de fondo de la película
  String overview; 
  String releaseDate;
  double voteAverage; // Promedio de votos de la película
  List<int> genreIds; // Lista de géneros asociados a la película

  // Constructor para inicializar los datos de la película
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreIds,
  });

  // Método para crear un objeto Movie desde un mapa (ej. JSON)
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int, 
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      genreIds: List<int>.from(map['genre_ids']),
    );
  }

  // Método para crear un objeto Movie desde una cadena JSON
  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
