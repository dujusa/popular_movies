import 'package:dio/dio.dart';
import 'package:popular_movies/model/movie_details.dart';
import 'package:popular_movies/model/movie_result.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl : "https://api.themoviedb.org/3/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("movie/popular")
  Future<MovieResult> getPopularMovies(@Query("api_key") String apiKey);

  @GET("movie/{movie_id}")
  Future<MovieDetails> getMovieDetails(@Path("movie_id")String movieId, @Query("api_key") String apiKey) ;

}