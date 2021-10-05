import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';
part 'movie_result.g.dart';



@JsonSerializable()
class MovieResult extends Equatable{

  @JsonKey(name: 'results')
  final List<Movie> results;
  @JsonKey(name: 'page')
  final int page;
  @JsonKey(name: 'total_results')
  final int totalResults;
  @JsonKey(name: 'total_pages')
  final int totalPages;


  MovieResult(this.page,this.results,this.totalPages,this.totalResults);


  factory MovieResult.fromJson(Map<String, dynamic> json) =>
      _$MovieResultFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResultToJson(this);


  @override
  // TODO: implement props
  List<Object?> get props => [
   results,page,totalResults,totalPages
  ];


}