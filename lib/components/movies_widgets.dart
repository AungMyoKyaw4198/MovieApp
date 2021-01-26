import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youTubeApp/model/movie.dart';
import 'package:youTubeApp/screen/movie/category_movie_screen.dart';
import 'package:youTubeApp/screen/movie/detail_movie_screen.dart';
import 'package:youTubeApp/screen/movie/view_movie_screen.dart';
import 'package:youTubeApp/services/ads.dart';

Widget movieCategories(String imageURL,String title,List<Movie> movieList,context){
  return GestureDetector(
      onTap: () {
          List<Movie> searchedMovies = new List();
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
                child: CachedNetworkImage(imageUrl: imageURL,
                height: 50,width: 100, fit: BoxFit.cover,)
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

Widget recommendMovie(Movie movie,context){
  return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
        builder: (context)=> DetailMovieScreen(movie: movie)),);
      },
        child: Container(
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
                child: CachedNetworkImage(imageUrl: movie.posterUrl,
                height: 150,width: 180, fit: BoxFit.fill,
                )
              ),
            ),
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
              alignment: Alignment.centerLeft,
              child: Text(movie.title,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
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

Widget gridMovie(Movie movie,context){
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
                child: CachedNetworkImage(imageUrl: movie.posterUrl,
                       width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                )
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

Widget watchButton(context, buttonText ,videoId,AdmobInterstitial interstitialAd){
  return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 30,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffecba1a),
          ),
          child: OutlineButton(
            color: Colors.yellow[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(buttonText),
                Icon(Icons.play_circle_fill),
              ]),
            onPressed: (){
                AdManager.loadFullScreenAd(interstitialAd);
                Navigator.push(context, MaterialPageRoute(
                builder: (context)=> ViewMovieScreen(videoId: videoId,)),);
              },
          ),
        );
}