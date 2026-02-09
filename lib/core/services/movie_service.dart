import 'dart:convert';

import '../interfaces/movies_list_interface.dart';
import '../models/movies_list_popular_response.dart';
import '../models/movie_credits_response.dart';
import 'package:http/http.dart' as http;

enum MovieListType {
  popular("popular"),
  topRated("top_rated"),
  nowPlaying("now_playing"),
  upcoming("upcoming");

  final String value;
  const MovieListType(this.value);
}

class MovieService implements MoviesListInterface {
  final String _apiBaseUrl = "https://api.themoviedb.org/3/movie";
  final String _accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlOTMyN2NmYWZmNGYxZWMzZTc2YjQwOGY2NjZhZTZjNiIsIm5iZiI6MTc2MzM2Nzc2NS40MDQsInN1YiI6IjY5MWFkYjU1MjE4MTBlZTc2YTE3NWQ4NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1r4iV_ii3HDaBU-ly5c8ao_gGMt6KZ-7gDwE-GJGB4I";

  @override
  Future<List<Movie>> getList(MovieListType listType) async {
    final uri = Uri.parse("$_apiBaseUrl/${listType.value}");
    
    try {
      var response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'accept': 'application/json',
        },
      );
      
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var moviesList = MovieListPopularResponse.fromJson(
          json.decode(response.body),
        ).results;
        return moviesList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error al obtener las películas populares: $e");
    }
  }

  Future<MovieCreditsResponse> getMovieCredits(int movieId) async {
    final uri = Uri.parse("$_apiBaseUrl/$movieId/credits");
    
    try {
      var response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'accept': 'application/json',
        },
      );
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var credits = MovieCreditsResponse.fromJson(
          json.decode(response.body),
        );

        return credits;
      } else {
        throw Exception("Error al obtener créditos de la película: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al obtener créditos de la película: $e");
    }
  }
}
