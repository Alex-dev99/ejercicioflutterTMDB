part of 'popular_movies_bloc.dart';

abstract class PopularMoviesEvent {
  const PopularMoviesEvent();

  List<Object> get props => [];
}

class FetchPopularMoviesEvent extends PopularMoviesEvent {
  final MovieListType movieListType;
  
  const FetchPopularMoviesEvent({this.movieListType = MovieListType.popular});

  @override
  List<Object> get props => [movieListType];
}
