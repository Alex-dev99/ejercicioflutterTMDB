import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/bloc/popular_movies_bloc.dart';
import 'package:flutter_tmdb/core/services/movie_service.dart';
import 'package:flutter_tmdb/widgets/cast_carousel.dart';
import 'package:flutter_tmdb/widgets/movie_carousel.dart';
import 'package:flutter_tmdb/widgets/movie_filter_buttons.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  MovieListType _currentMovieType = MovieListType.popular;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Movie DB'),
      ),
      body: BlocProvider(
        create: (context) => PopularMoviesBloc()
          ..add(FetchPopularMoviesEvent(movieListType: _currentMovieType)),
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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Películas',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              MovieFilterButtons(
                                currentMovieType: _currentMovieType,
                                onPopularPressed: () {
                                  setState(() {
                                    _currentMovieType = MovieListType.popular;
                                  });
                                  context.read<PopularMoviesBloc>().add(
                                    FetchPopularMoviesEvent(
                                      movieListType: MovieListType.popular,
                                    ),
                                  );
                                },
                                onTopRatedPressed: () {
                                  setState(() {
                                    _currentMovieType = MovieListType.topRated;
                                  });
                                  context.read<PopularMoviesBloc>().add(
                                    FetchPopularMoviesEvent(
                                      movieListType: MovieListType.topRated,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          MovieCarousel(movies: state.movies),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Actores Principales',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          CastCarousel(castList: state.castList),
                        ],
                      ),
                    ),
                  ],
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