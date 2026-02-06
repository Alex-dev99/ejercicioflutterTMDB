import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/bloc/popular_movies_bloc.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas Populares'),
      ),
      body: BlocProvider(
        create: (context) => PopularMoviesBloc()
          ..add(const FetchPopularMoviesEvent()),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesInitial) {
              return const Center(
                child: Text('Presiona para cargar películas'),
              );
            } else if (state is PopularMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMoviesLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Card(
                        elevation: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Poster Image
                                movie.posterPath != null
                                    ? Image.network(
                                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                        height: 200,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 200,
                                            color: const Color.fromARGB(255, 126, 124, 124),
                                            child: const Icon(Icons.image_not_supported),
                                          );
                                        },
                                      )
                                    : Container(
                                        height: 200,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.image_not_supported),
                                      ),
                                // Movie Info
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(Icons.star,
                                                size: 12,
                                                color: Colors.amber),
                                            const SizedBox(width: 4),
                                            Text(
                                              movie.voteAverage
                                                  .toStringAsFixed(1),
                                              style: const TextStyle(
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is PopularMoviesError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            }
            return const Center(
              child: Text('Estado desconocido'),
            );
          },
        ),
      ),
    );
  }
}
