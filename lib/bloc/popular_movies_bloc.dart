import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/core/models/movies_list_popular_response.dart';
import 'package:flutter_tmdb/core/services/movie_service.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final MovieService _movieService = MovieService();

  PopularMoviesBloc() : super(const PopularMoviesInitial()) {
    on<FetchPopularMoviesEvent>(_onFetchPopularMovies);
  }

  Future<void> _onFetchPopularMovies(
    FetchPopularMoviesEvent event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(const PopularMoviesLoading());
    try {
      final movies = await _movieService.getList(MovieListType.popular);
      emit(PopularMoviesLoaded(movies: movies));
    } catch (e) {
      emit(PopularMoviesError(
        message: e.toString(),
      ));
    }
  }
}
