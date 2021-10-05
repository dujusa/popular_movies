import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_details.g.dart';


@JsonSerializable()
class MovieDetails extends Equatable{


  @JsonKey(name:'id')
  final int id;
  @JsonKey(name: 'overview')
  final String overview;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'poster_path', nullable: true)
  final String ? posterPath;



  MovieDetails(this.id, this.overview, this.voteAverage, this.posterPath);


  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);


  @override
  List<dynamic> get props => [
    id,
    overview,
    posterPath,
    voteAverage
  ];


}