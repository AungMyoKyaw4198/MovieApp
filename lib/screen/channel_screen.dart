import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youTubeApp/components/appbar_widget.dart';
import 'package:youTubeApp/components/widget.dart';
import 'package:youTubeApp/model/channel.dart';
import 'package:youTubeApp/model/video.dart';
import 'package:youTubeApp/services/api_service.dart';

class ChannelScreen extends StatefulWidget {
  final Channel channel;
  ChannelScreen({this.channel});

  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  bool _isLoading = true;

  // Function for loading videos
   _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: widget.channel.uploadPlaylistId);
    List<Video> allVideos = widget.channel.videos..addAll(moreVideos);
    setState(() {
      widget.channel.videos = allVideos;
    });
    _isLoading = false;
  }

  // opening channel url
  _launchURL(context,String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    showMessage(context,'Could not launch URL at this time! Please try again.');
  }
}

  @override
  void initState() {
    super.initState();
    _loadMoreVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: Color(0xff141a32),
            appBar: mainAppBar(),
            body: NotificationListener<ScrollNotification>(

              // load more videos when scrolling ends
              onNotification: (ScrollNotification scrollDetails) {
                      if (!_isLoading &&
                          widget.channel.videos.length != int.parse(widget.channel.videoCount) &&
                          scrollDetails.metrics.pixels ==
                              scrollDetails.metrics.maxScrollExtent) {
                        _loadMoreVideos();
                      }
                      return false;
                    },
        child: SingleChildScrollView(
         child: Column(
            children: <Widget>[

              // Show channel profile
              Container(
                height: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      backgroundImage: NetworkImage(widget.channel.profilePictureUrl),
                    ),
                ),
              Container(
               alignment: Alignment.center,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height:10),
                  // Conditions
                  widget.channel.title=='မဟာ' 
                  ?Text(
                      'Mahar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.clip,
                    )
                  :Text(
                    widget.channel.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                        ),
                    SizedBox(height:5),
                    Text(
                       ' ${widget.channel.videoCount} Videos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height:5),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffecba1a),
                        ),
                          child: OutlineButton(
                          color: Colors.yellow[700],
                          child: Text("Watch on Youtube"),
                          onPressed: (){
                             _launchURL(context,'https://www.youtube.com/channel/${widget.channel.id}');
                          },
                        ),
                      ),
                    ]
                          ),
                          ),
              ]
                ),
              ),

              // 'All Videos' Text
              Container(
                margin: EdgeInsets.only(left: 20,top: 10,bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text('All Videos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
              ),

              // Show video container
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
                  crossAxisCount: 2,
                  children: List.generate(widget.channel.videos.length, (index){
                    return buildVideoChannel(video: widget.channel.videos[index],context: context);
                  }
                  ),),
              ),
              SizedBox(height: 30),
            ],),
    ),
       ),
    )
    
    
    ;
  }
}