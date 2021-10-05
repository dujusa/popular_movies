import 'package:popular_movies/model/movie_details.dart';
import 'package:popular_movies/resources/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

final moviesDetailsBloc = MoviesDetailsBloc();
class MoviesDetailsBloc {

  final BehaviorSubject<MovieDetails> _movieDetailsSubject =
  BehaviorSubject<MovieDetails>();
  final MovieRepository _movieRepository = MovieRepository();

  Stream<MovieDetails> get movieDetails => _movieDetailsSubject.stream;

  getMovieDetails(String id) async {
    MovieDetails response = await _movieRepository.getMovieDetails(id);
    _movieDetailsSubject.sink.add(response);
  }

  dispose() {
    _movieDetailsSubject.close();
  }

}
