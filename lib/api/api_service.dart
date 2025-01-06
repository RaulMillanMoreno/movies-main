import 'dart:convert';
import 'package:movies/api/api.dart';
import 'package:movies/models/descactor.dart';
import 'package:movies/models/actor.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/review.dart';

class ApiService {

  static Future<List<Actor>?> getTopRatedActors() async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}trending/person/week?language=en-US&api_key=${Api.apiKey}'));// el acceso a la api en el apartado de actores.
      var res = jsonDecode(response.body);
      res['results'].skip(6).take(5).forEach(
            (m) => actors.add(
              Actor.fromMap(m),
            ),
          );
      return actors;
    } catch (e) {
      return null;
    }
  }

  static Future<DescActor?> getDetailyActor(String idactor) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${Api.baseUrl}person/$idactor?api_key=${Api.apiKey}&language=en-US'),
      );
      var res = jsonDecode(response.body); // Devuelve un objeto, no una lista
      return DescActor.fromMap(res); // Mapea directamente al modelo DescActor
    } catch (e) {
      return null; // Retorna null en caso de error
    }
  }


   static Future<List<Actor>?> getCustomActors(String url) async {
    List<Actor> actors = [];
    try {
      http.Response response =
          await http.get(Uri.parse('${Api.baseUrl}person/popular?language=en-US&api_key=${Api.apiKey}${url}'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
            (m) => actors.add(
              Actor.fromMap(m),
            ),
          );
      return actors;
    } catch (e) {
      return null;
    }
  }


  static Future<List<Actor>?> getSearchedActors(String query) async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/person?language=en-US&api_key=${Api.apiKey}&include_adult=false&query=$query'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (m) => actors.add(
          Actor.fromMap(m),
        ),
      );
      return actors;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (r) {
          reviews.add(
            Review(
                author: r['author'],
                comment: r['content'],
                rating: r['author_details']['rating']),
          );
        },
      );
      return reviews;
    } catch (e) {
      return null;
    }
  }

}
