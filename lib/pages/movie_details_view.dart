import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:popular_movies/bloc/movie_details_bloc.dart';
import 'package:popular_movies/model/movie_details.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../common/style.dart' as constants;


class MovieDetailsView extends StatefulWidget {

  final dynamic movieId;
  const MovieDetailsView({@required this.movieId,Key? key}) : super(key: key);

  @override
  _MovieDetailsViewState createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  @override
  void initState() {
    super.initState();
    moviesDetailsBloc.getMovieDetails(widget.movieId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie details")
      ),
      body: StreamBuilder(
        stream: moviesDetailsBloc.movieDetails,
        builder: (context, AsyncSnapshot<MovieDetails> snapshot) {
          if (snapshot.hasData) {
            return buildMovieDetails(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }


  Widget buildMovieDetails(AsyncSnapshot<MovieDetails> snapshot) {
      return SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.only(left: 10, top:10),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      margin:const EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width - 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: AspectRatio(
                            aspectRatio: 0.8,
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl:'https://image.tmdb.org/t/p/w185${snapshot.data?.posterPath}',
                              placeholder: (context, url) =>  const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Text("error"),
                            )
                        ),
                      ),
                    ),
                    Positioned.fill(child: Align(
                      child:Padding(padding: const EdgeInsets.only(left: 15),child:
                      getMovieScore(snapshot.data!.voteAverage)),
                      alignment: Alignment.bottomLeft,
                    )),
                  ],
                )
              ],
            ),
            Padding(padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,//.horizontal
                        child:  Text(snapshot.data!.overview,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: constants.appFontSize, color: constants.appMainTextColor,
                              height: 1.5
                          ),
                        ),
                      ),
                    ),

                  ],
                ))
          ],
        )
      ));
  }

  Widget getMovieScore(double movieScore) {
    return Stack(
      children: [
        const CircleAvatar(
            backgroundColor: constants.appMainColor,
            radius: 26.0
        ),
        Positioned(
            bottom: 0,
            right: 0,
            top:0,
            left: 0,
            child: CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 2.0,
              percent: movieScore/10,
              center: Text((movieScore*10).toInt().toString() + "%", style: const TextStyle(color: Colors.white)),
              progressColor: Colors.green,
              backgroundColor: Colors.transparent,
            )),
      ],
    );
  }


}
