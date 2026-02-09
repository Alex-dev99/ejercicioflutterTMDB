import 'package:flutter/material.dart';
import 'package:flutter_tmdb/core/models/movies_list_popular_response.dart';
import 'package:flutter_tmdb/widgets/movie_card.dart';

class MovieCarousel extends StatelessWidget {
  final List<Movie> movies;

  const MovieCarousel({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieCard(movie: movies[index]);
        },
      ),
    );
  }
}
