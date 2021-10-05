import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:popular_movies/model/movie.dart';
import 'package:popular_movies/pages/movie_details_view.dart';
import 'package:popular_movies/pages/movie_list.dart';


void main() {
  testWidgets('Movie list', (WidgetTester tester) async {
    await tester.runAsync(() async {

      await tester.pumpWidget(const MaterialApp(
        home: MovieList(),
      ));

      expect(find.text('Popular movies'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.search));

    });
  });}
