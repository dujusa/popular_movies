// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetails _$MovieDetailsFromJson(Map<String, dynamic> json) => MovieDetails(
      json['id'] as int,
      json['overview'] as String,
      (json['vote_average'] as num).toDouble(),
      json['poster_path'] as String?,
    );

Map<String, dynamic> _$MovieDetailsToJson(MovieDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'overview': instance.overview,
      'vote_average': instance.voteAverage,
      'poster_path': instance.posterPath,
    };
