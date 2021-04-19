import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youTubeApp/components/movies_widgets.dart';
import 'package:youTubeApp/components/widget.dart';
import 'package:youTubeApp/model/movie.dart';
import 'package:youTubeApp/model/video.dart';
import 'package:youTubeApp/services/ads.dart';
import 'package:youTubeApp/util/favouriteVideos.dart';
import 'package:youTubeApp/util/objectConverter.dart';

class DetailMovieScreen extends StatefulWidget {
  final Movie movie;
  final FavoriteVideos favs = FavoriteVideos();
  DetailMovieScreen({this.movie});


  // add to favourite list
  updateFavourite(Movie movie) async {
    await favs.addFavorite(convertMovieToVideo(movie));
  }

  @override
  _DetailMovieScreenState createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  List<Video> videoList = [];
  List<Video> videos;
  bool hasMultiParts = false;
  AdmobInterstitial interstitialAd;
  bool isAldyFav = false;

  // check whether current video is already favourite or not?
  loadFavourite(Video video) async {
    List<Video> videos =await widget.favs.readAllFavorites();
    setState(() {
      videoList = videos;
       if(videoList.any((p) => p.title == video.title)){
         isAldyFav = true;
       }
       else{
        isAldyFav = false;
       }
    });
  }


  @override
  void initState() { 
    super.initState();
    if(widget.movie.url.length >1){
      setState(() {
              hasMultiParts = true;
      });
    }
    loadFavourite(convertMovieToVideo(widget.movie));
    interstitialAd = AdManager.initFullScreenAd(interstitialAd);
    interstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBodyBehindAppBar: true,
       backgroundColor: Color(0xff141a32),
       appBar: AppBar(backgroundColor: Colors.transparent,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Expanded(
                      //   flex: 2,
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: IconButton(icon: Icon(Icons.arrow_back,), onPressed: (){
                      //       Navigator.pushReplacement(context, MaterialPageRoute(
                      //       builder: (context)=> AllMoviesScreen()),);
                      //     },alignment: Alignment.centerLeft,),
                      //   ),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xff141a32),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        // width: 150,
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(widget.movie.category,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18),overflow: TextOverflow.visible,),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red[300],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        width: 100,
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(widget.movie.subtitle,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18),),
                      ),
                      ]
                  ),
                
            ),
       body: SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: Container(
           padding: EdgeInsets.only(bottom: 14),
           margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Container(
                 width: MediaQuery.of(context).size.width,
                 child: CachedNetworkImage(imageUrl:widget.movie.posterUrl,height: 400,fit: BoxFit.fill,),
               ),
               Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                  alignment: Alignment.centerLeft,
                  child: Text(widget.movie.title,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
                ),
                
                 SizedBox(height: 5,),
                 hasMultiParts? Container(
                     height: 30,
                     child: ListView.builder(
                       scrollDirection: Axis.horizontal,
                       itemCount: widget.movie.url.length,
                       itemBuilder: (BuildContext context, int index){
                         return Center(
                           child: watchButton(context, 'Link ${index+1}',widget.movie.url[index].toString(),interstitialAd ));
                     }),
                   ): watchButton(context, 'Watch', widget.movie.url[0].toString(),interstitialAd),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                        alignment: Alignment.centerLeft,
                        child: Text('Review',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                      ),

                      // Is already Favourites??
                      isAldyFav?
                      IconButton(icon: Icon(Icons.favorite, color: Colors.red,), onPressed: (){
                      setState(() {
                        widget.favs.removeFavorite(convertMovieToVideo(widget.movie));
                        isAldyFav = false;
                      });
                      showMessage(context,'Removed from favourite');
                      }): 
                      IconButton(icon: Icon(Icons.favorite_border, color: Colors.red,), onPressed: (){
                      setState(() {
                        widget.updateFavourite(widget.movie);
                        isAldyFav = true;
                      });
                      showMessage(context,'Added to favourite');
                      }),
                  
                  ] 
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    widget.movie.description,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 12),
                  ),
                )
              ],
          ),
          
        ),
      )
    );
  }

  @override
    void dispose() {
      print('________________________Dispose Detail Movie Screen');
      super.dispose();
    }
}