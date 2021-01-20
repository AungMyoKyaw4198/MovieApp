import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewMovieScreen extends StatefulWidget {
  final String videoId;
  ViewMovieScreen({this.videoId});

  @override
  _ViewMovieScreenState createState() => _ViewMovieScreenState();
}

class _ViewMovieScreenState extends State<ViewMovieScreen> {
  YoutubePlayerController _controller;
  bool playerHasError = false;

  @override
  void initState() { 
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
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
       appBar: AppBar(backgroundColor: Colors.transparent,),
       body: Center(
         child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                            ),
                     builder: (context, player){
                       return player;
                     }
          ),
       )
    );
  }
}