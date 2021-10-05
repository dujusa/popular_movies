import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:popular_movies/model/movie_details.dart';
import 'package:popular_movies/pages/movie_details_view.dart';


void main() {
  testWidgets('Movie details', (WidgetTester tester) async {
    await tester.runAsync(() async {

      await tester.pumpWidget(const MaterialApp(
        home: MovieDetailsView(
          movieId: 550988,
        ),
      ));
      expect(find.text('Popular movies'), findsOneWidget);
    });
  });}
