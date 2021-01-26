import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:youTubeApp/components/appbar_widget.dart';
import 'package:youTubeApp/components/widget.dart';
import 'package:youTubeApp/model/movie.dart';
import 'package:youTubeApp/model/video.dart';
import 'package:youTubeApp/screen/video_screen.dart';
import 'package:youTubeApp/services/ads.dart';
import 'package:youTubeApp/util/favouriteVideos.dart';
import 'package:youTubeApp/util/objectConverter.dart';

import 'movie/detail_movie_screen.dart';

class FavScreen extends StatefulWidget {
  static const String routeName= '/fav';
  final FavoriteVideos favs = FavoriteVideos();
  FavScreen({Key key}) : super(key: key);

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  AdmobInterstitial interstitialAd;
  BannerAd myBannerAd;
  List<Video> videoList = new List();
  List<Movie> movieList = new List();
  List<Video> videos;
  List<Movie> movies;

  // load favorite videos
  loadFavourite() async {
    List<Video> videos =await widget.favs.readAllFavorites();
    setState(() {
      videoList = videos;
      movieList = movies;
    });
  }

  bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
  }

  @override
  void initState() {
    super.initState();
    interstitialAd = AdManager.initFullScreenAd(interstitialAd);
    interstitialAd.load();
    loadFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
        backgroundColor: Color(0xff141a32),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text('Favourite Videos'),
            ),
        drawer: drawerWidget(context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AdManager.largeBannerAdWidget(),
              // favourite video list
              Container(
                child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: videoList.length,
                      itemBuilder: (BuildContext context, int index){
                          return GestureDetector(
                            onTap: () {
                              AdManager.loadFullScreenAd(interstitialAd);
                              print(isNumeric(videoList[index].id));
                              if(isNumeric(videoList[index].id)){
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailMovieScreen(movie: convertVideoToMovie(videoList[index]),),
                                ),
                                );
                              }else{
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => VideoScreen(video: videoList[index],),
                                  ),
                                );
                              }
                              },
                              child: favVideoListView(videoList[index].thumbnailUrl,videoList[index].title,videoList[index].channelTitle),
                        );
                      }
                  ),
              ),

              ],
            ),)
       ),
    );
  }
}

