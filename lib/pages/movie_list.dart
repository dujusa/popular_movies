import 'package:flutter/material.dart';
import 'package:popular_movies/bloc/movies_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:popular_movies/model/movie.dart';
import 'package:popular_movies/model/movie_result.dart';
import 'package:popular_movies/pages/movie_details_view.dart';

import '../common/style.dart' as constants;

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    moviesBloc.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular movies"),
        elevation: 0.0,
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                showSearch(context: (context), delegate: MovieSearch());
              })
        ],
      ),
      body: StreamBuilder(
        stream: moviesBloc.popularMovies,
        builder: (context, AsyncSnapshot<MovieResult> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<MovieResult> snapshot) {
    return MovieListView(movies: snapshot.data?.results);
  }

}

class MovieListView extends StatefulWidget {
  List<Movie> ? movies ;
   MovieListView({Key? key,  required this.movies}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MovieListViewState();
  }
}

class _MovieListViewState extends State<MovieListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.movies!.length,
      itemBuilder: (_, index) {
        return Column(
          children: [
            InkWell(
                onTap: (){
                  openMovieDetails(widget.movies![index].id);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: 'https://image.tmdb.org/t/p/w185${widget.movies![index].posterPath}',
                                        errorWidget: (context, url, error) => const Text("error"),
                                        imageBuilder: (context, imageProvider) => CircleAvatar(
                                          radius: 24,
                                          backgroundImage: imageProvider,
                                        ),
                                      )
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(left: 8, right: 8),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          width: 250,
                                          child: Text(
                                              widget.movies![index].title,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontFamily:
                                                  'SFProDisplaySemibold',
                                                  fontSize: constants.appFontSize,
                                                  color:
                                                  constants.appMainTextColor)))
                                    ],
                                  ))
                            ],
                          )
                        ],
                      ),
                      Column(
                        children:  const [
                          Padding(padding: EdgeInsets.only(right: 6, left: 4),
                              child: Icon(IconData(59484, fontFamily: 'MaterialIcons', matchTextDirection: true), size: 28.0, color: constants.lineColor))
                        ],
                      )
                    ],
                  ),
                )
            ),
            Row(
              children: const [
                Expanded(
                  child: Divider(
                    color: constants.lineColor,
                    thickness: 1,
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

  openMovieDetails(movieId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieDetailsView(movieId: movieId,)));
  }
}


class MovieSearch extends SearchDelegate<String> {
  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            )
          ],
        ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error: $error"),
          ],
        ));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, "");
        });
  }



  @override
  Widget buildSuggestions(BuildContext context) {
    moviesBloc.getPopularMovies();
    return StreamBuilder<MovieResult>(
        stream: moviesBloc.popularMovies,
        builder: (context, AsyncSnapshot<MovieResult> snapshot) {
          if (snapshot.hasData) {
            return listWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error.toString());
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget listWidget(MovieResult? data) {
    final List<Movie> suggestionList = query.isEmpty
        ? data!.results.take(0).toList()
        : data!.results.where((q) => q.title.toLowerCase().startsWith(query.toLowerCase())).toList();

    return MovieListView(movies:suggestionList );
  }
  @override
  Widget buildResults(BuildContext context) {return Container();}

}



