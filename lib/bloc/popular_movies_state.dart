part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState {
  const PopularMoviesState();

  List<Object> get props => [];
}

class PopularMoviesInitial extends PopularMoviesState {
  const PopularMoviesInitial();
}

class PopularMoviesLoading extends PopularMoviesState {
  const PopularMoviesLoading();
}

class PopularMoviesLoaded extends PopularMoviesState {
  final List<Movie> movies;
  final List<Cast> castList;

  const PopularMoviesLoaded({
    required this.movies,
    required this.castList,
  });

  @override
  List<Object> get props => [movies, castList];
}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  const PopularMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
