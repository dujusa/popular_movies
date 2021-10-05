import 'package:flutter_test/flutter_test.dart';
import 'package:popular_movies/bloc/movies_bloc.dart';
import 'package:popular_movies/model/movie_result.dart';

Future<void> main() async {
  const _json = {
    "results": [
      {
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
      },
    ],
    "page": 1,
    "total_pages": 500,
    "total_results": 10000
  };

  MoviesBloc moviesBloc = MoviesBloc();
  MovieResult movieResult = MovieResult.fromJson(_json);

  final list = [
    MovieResult.fromJson(_json),
  ];

  test(
    'When start bloc '
    'Should emits the list of movies',
    ()  async {
      await moviesBloc.getPopularMovies();
      expectLater( (await moviesBloc.popularMovies.first), isA<MovieResult>());
      expectLater( (await moviesBloc.popularMovies.first).results.contains(movieResult.results[0]), true);

    },
  );

}
