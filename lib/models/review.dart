class Review {
  // Variables que contienen la información de la reseña
  String author; 
  String comment; 
  double rating; // Calificación de la reseña (valor numérico)

  // Constructor para inicializar los datos de la reseña
  Review({
    required this.author,
    required this.comment,
    required this.rating,
  });

  // Método para crear un objeto Review desde un mapa (ej. JSON)
  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      author: map['name'] ?? '', 
      comment: map['content'] ?? '', 
      rating: map['rating']?.toDouble() ?? 0.0, 
    );
  }
}
