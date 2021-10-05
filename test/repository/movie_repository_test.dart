
import 'package:flutter_test/flutter_test.dart';
import 'package:popular_movies/model/movie.dart';
import 'package:popular_movies/model/movie_details.dart';
import 'package:popular_movies/model/movie_result.dart';
import 'package:popular_movies/resources/repository/movie_repository.dart';


void main() {
  MovieRepository movieRepository =  MovieRepository();

  const _json = {
        "popularity": 11516.441,
        "vote_count": 2061,
        "video": false,
        "poster_path": "/xmbU4JTUm8rsdtn7Y3Fcm30GpeT.jpg",
        "id": 550988,
        "adult": false,
        "backdrop_path": "/8Y43POKjjKDGI9MH89NW0NAzzp8.jpg",
        "original_language": "en",
        "original_title": "Free Guy",
        "genre_ids": [35, 28, 12, 878],
        "title": "Free Guy",
        "vote_average": 7.9,
        "release_date": "2021-08-11",
        "overview":
        "A bank teller called Guy realizes he is a background character in an open world video game called Free City that will soon go offline."
  };

 test(
      'Get movie details '
          'Should return the correct movie', () async {

    MovieDetails movieDetails = MovieDetails.fromJson(_json);
    MovieDetails movieDetailsResponse = await movieRepository.getMovieDetails("550988");

    expect(movieDetails==movieDetailsResponse, true);
  });

  test(
      'When get popular movies '
          'Should return list of movies', () async {
    Movie movie = Movie.fromJson(_json);
    final list = await movieRepository.getPopularMovies();
    //checking response type
    expect(list, isA<MovieResult>());
    expect(list.results.contains(movie), true);

  });
}