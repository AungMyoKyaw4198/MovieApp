import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:youTubeApp/model/video.dart';
import 'package:youTubeApp/screen/home.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youTubeApp/util/favouriteVideos.dart';
import 'package:youTubeApp/components/widget.dart';

class VideoScreen extends StatefulWidget {
  final Video video;
  final FavoriteVideos favs = FavoriteVideos();

  VideoScreen({this.video});

  // add to favourite list
  updateFavourite(Video video) async {
    await favs.addFavorite(video);
  }

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List<Video> videoList = new List();
  YoutubePlayerController _controller;
  List<Video> videos;
  bool isAldyFav = false;
  bool playerHasError = false;

  // check whether current video is already favourite or not?
  loadFavourite(Video video) async {
    List<Video> videos =await widget.favs.readAllFavorites();
    setState(() {
      videoList = videos;
       if(videoList.any((p) => p.id == video.id)){
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
    loadFavourite(widget.video);
    // youtube video player
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
      ),
    )..addListener(() {
      if(_controller.value.hasError){
        setState(() {
          playerHasError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Color(0xff141a32),
            appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    ),
            body: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                            ),
                    builder: (context, player){
                        return Column(
                          children: [
                          player,

                          // Show video title
                          Container(
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xff1e2747),
                              padding: EdgeInsets.symmetric(horizontal:10,vertical: 10),
                              child: Text(widget.video.title, 
                              style: TextStyle(color: Colors.white,
                              fontSize: 20),)
                            ),

                          // Show channel title and favourite button
                          Container(
                              color: Color(0xff1e2747),
                              padding: EdgeInsets.symmetric(horizontal:5),
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                  FlatButton(
                                    child: Text(widget.video.channelTitle, style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            )),
                                    onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=> Home()),);
                                      },),
                                        isAldyFav?
                                          IconButton(icon: Icon(Icons.favorite, color: Colors.red,), onPressed: (){
                                          setState(() {
                                            widget.favs.removeFavorite(widget.video);
                                            isAldyFav = false;
                                          });
                                          showMessage(context,'Removed from favourite');
                                          }): 
                                          IconButton(icon: Icon(Icons.favorite_border, color: Colors.red,), onPressed: (){
                                      setState(() {
                                        widget.updateFavourite(widget.video);
                                        isAldyFav = true;
                                      });
                                      showMessage(context,'Added to favourite');
                                      }),
                                      ],),
                          ),

                          Container(
                            color: Color(0xff1e2747),
                            height: 20,),
                            ],
                        );
                  }
                  ),
            )
    );
  }

}