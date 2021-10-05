import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie.g.dart';


@JsonSerializable()
class Movie extends Equatable{
  @JsonKey(name: 'adult')
  final bool adult;
  @JsonKey(name: 'backdrop_path',nullable: true)
  final String? backdropPath;
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  @JsonKey(name: 'overview')
  final String overview;
  @JsonKey(name: 'popularity')
  final double popularity;
  @JsonKey(name: 'poster_path', nullable: true)
  final String ? posterPath;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'video')
  final bool video;
  @JsonKey(name: 'vote_average')
  final double voteAverage;

    Movie(this.adult, this.backdropPath, this.genreIds, this.id, this.originalLanguage, this.originalTitle,
    this.overview,this.popularity,this.posterPath,this.releaseDate,this.voteCount,this.title,this.video,this.voteAverage);


  factory Movie.fromJson(Map<String, dynamic> json) =>
      _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  List<dynamic> get props => [
    adult,
    id,
    title,
    releaseDate,
    genreIds,
    posterPath,
    backdropPath,
    originalLanguage,
    originalTitle
  ];


}