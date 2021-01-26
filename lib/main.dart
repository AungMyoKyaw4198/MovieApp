import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youTubeApp/screen/fav_screen.dart';
import 'package:youTubeApp/screen/home.dart';
import 'package:youTubeApp/screen/movie/all_movie_screen.dart';
import 'package:youTubeApp/screen/radio_screen.dart';
import 'package:youTubeApp/screen/tv_channels.dart';
import 'package:youTubeApp/util/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize(testDeviceIds: ['ca-app-pub-8107971978330636~8056578093']);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ကြည့်ရအောင်',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AllMoviesScreen(),
      routes:  {
        Routes.movie: (context) => Home(),
        Routes.channel: (context) => TvChannel(),
        Routes.favVideo: (context) => FavScreen(),
        Routes.radio: (context) => RadioScreen(),
         Routes.movies: (context) => AllMoviesScreen(),
      },
    );
  }
}
