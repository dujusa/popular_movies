

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:popular_movies/model/movie_details.dart';
import 'package:popular_movies/model/movie_result.dart';

import '../api_client.dart';

class MovieRepository {

  Dio _dio = Dio();

  Dio get dio => _dio;

  set dio(Dio value) {
    _dio = value;
  }

  ApiClient ? _apiClient;

  final _logger = Logger();

  var apiKey = "4ff9d08260ed338797caa272d7df35dd";

  MovieRepository() {
    _dio = Dio();
    _apiClient = ApiClient(_dio);
  }

  Future<MovieResult> getPopularMovies() {
    return _apiClient!.getPopularMovies(apiKey).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
          _logger.e(obj);
      }
    });
  }

  Future<MovieDetails> getMovieDetails(String id) {
    return _apiClient!.getMovieDetails(id,apiKey).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          break;
        default:
          _logger.e(obj);
      }
    });
  }

}
