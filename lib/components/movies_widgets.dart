import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youTubeApp/model/movie.dart';
import 'package:youTubeApp/screen/movie/category_movie_screen.dart';
import 'package:youTubeApp/screen/movie/detail_movie_screen.dart';
import 'package:youTubeApp/screen/movie/view_movie_screen.dart';
import 'package:youTubeApp/services/ads.dart';


class MovieCategoriesWidget extends StatelessWidget {
  final String imageURL;
  final String title;
  final List<Movie> movieList;
  final BuildContext context;
  const MovieCategoriesWidget(this.imageURL,this.title,this.movieList,this.context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
        List<Movie> searchedMovies = [];
        movieList.forEach((value){
          if(value.category == title){
            searchedMovies.add(value);
          }
        });
        Navigator.push(context, MaterialPageRoute(
        builder: (context)=> CategoryMovieScreen(title: title.toUpperCase(),movieList: searchedMovies,)),);
    },
      child: Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: ClipRRect
            (
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imageURL,fit: BoxFit.cover,height: 50,width: 100,cacheHeight: 200,cacheWidth: 200,)
            ),
          ),
          Container(
            decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black45,
                      ),
            margin: EdgeInsets.symmetric(horizontal: 5),
            height: 50,width: 100,
            alignment: Alignment.center,
            child: Text(title.toUpperCase(),style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
            )
        ],),
    ),
    );
  }
}

class RecomdMoviesWidget extends StatelessWidget {
  final Movie movie;
  final BuildContext context;
  const RecomdMoviesWidget(this.movie,this.context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
        builder: (context)=> DetailMovieScreen(movie: movie)),);
      },
        child: Container(
          width: 190,
          margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xff1e2747),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: ClipRRect
              (
                borderRadius: BorderRadius.circular(8),
                child: Image.network(movie.posterUrl,height: 150,width: 180, fit: BoxFit.cover,cacheHeight: 200,cacheWidth: 200,)
              ),
            ),
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
              alignment: Alignment.centerLeft,
              child: Text(movie.title,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),overflow: TextOverflow.ellipsis,),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              color: Color(0xff141a32),
                            ),
                alignment: Alignment.centerLeft,
                child: Text(movie.category,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 13),),
            )
          ],
          ),
      ),
    ); 
  }
}

class GridMovieWidget extends StatelessWidget {
  final Movie movie;
  final BuildContext context;
  const GridMovieWidget(this.movie,this.context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
        builder: (context)=> DetailMovieScreen(movie: movie,)),);
      },
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: ClipRRect
              (
                borderRadius: BorderRadius.circular(8),
                child: Image.network(movie.posterUrl,fit: BoxFit.fill,width: MediaQuery.of(context).size.width,cacheHeight: 200,cacheWidth: 200,)
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    color: Colors.black54,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Text(movie.title,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                        Container(
                          margin: EdgeInsets.only(bottom: 3),
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: Color(0xff141a32),
                          ),
                          child: Text(movie.category,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 13),)),
                      ],)   
                  ),
                ],
                ),
            
          ],
          ),
    ); 
  }
}

class WatchButtonWidget extends StatelessWidget {
  final BuildContext context;
  final String buttonText;
  final String videoId;
  final AdmobInterstitial interstitialAd;
  const WatchButtonWidget(this.context,this.buttonText,this.videoId,this.interstitialAd);

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 30,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffecba1a),
          ),
          child: OutlinedButton(
            // color: Colors.yellow[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(buttonText,style: TextStyle(color: Colors.black),),
                Icon(Icons.play_circle_fill,color: Colors.black,),
              ]),
            onPressed: (){
                AdManager.loadFullScreenAd(interstitialAd);
                Navigator.push(context, MaterialPageRoute(
                builder: (context)=> ViewMovieScreen(videoId: videoId,)),);
              },
          ),
        );
  }
}
