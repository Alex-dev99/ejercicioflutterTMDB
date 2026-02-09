import 'package:flutter/material.dart';
import 'package:flutter_tmdb/core/services/movie_service.dart';

class MovieFilterButtons extends StatelessWidget {
  final MovieListType currentMovieType;
  final VoidCallback onPopularPressed;
  final VoidCallback onTopRatedPressed;

  const MovieFilterButtons({
    super.key,
    required this.currentMovieType,
    required this.onPopularPressed,
    required this.onTopRatedPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: currentMovieType == MovieListType.popular ? null : onPopularPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: currentMovieType == MovieListType.popular
                ? Colors.deepPurple
                : Colors.white,
          ),
          child: const Text(
            'Popular',
            style: TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: currentMovieType == MovieListType.topRated ? null : onTopRatedPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: currentMovieType == MovieListType.topRated
                ? Colors.deepPurple
                : Colors.white,
          ),
          child: const Text(
            'Top Rated',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
