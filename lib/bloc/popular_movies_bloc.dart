import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/core/models/movies_list_popular_response.dart';
import 'package:flutter_tmdb/core/models/movie_credits_response.dart';
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
      final movies = await _movieService.getList(event.movieListType);
      
      final moviesWithPoster = movies.where((m) => m.posterPath != null && m.posterPath!.isNotEmpty).toList();
      
      List<Cast> castList = [];
      if (movies.isNotEmpty) {
        try {
          final credits = await _movieService.getMovieCredits(movies[0].id);
          if (credits.cast.isNotEmpty) {
            final actoresConFoto = credits.cast.where((a) => a.profilePath != null && a.profilePath!.isNotEmpty).toList();
            castList = actoresConFoto.take(10).toList(); 
          }
        } catch (e) {
          castList = [];
        }
      }
      
      emit(PopularMoviesLoaded(movies: moviesWithPoster, castList: castList));
    } catch (e) {
      emit(PopularMoviesError(
        message: e.toString(),
      ));
    }
  }
}
