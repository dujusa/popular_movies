


import 'package:popular_movies/model/movie_result.dart';
import 'package:popular_movies/resources/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

final moviesBloc = MoviesBloc();
class MoviesBloc {

  final BehaviorSubject<MovieResult> _moviesSubject = BehaviorSubject<MovieResult>();
  final MovieRepository _movieRepository = MovieRepository();


  Stream<MovieResult> get popularMovies => _moviesSubject.stream;

  getPopularMovies() async {
    MovieResult response = await _movieRepository.getPopularMovies();
    _moviesSubject.sink.add(response);
  }

  dispose() {
    _moviesSubject.close();
  }

}
