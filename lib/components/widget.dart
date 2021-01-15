import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:youTubeApp/model/channel.dart';
import 'package:youTubeApp/model/video.dart';
import 'package:youTubeApp/screen/channel_screen.dart';
import 'package:youTubeApp/screen/video_screen.dart';

Widget buildProfileInfo({Channel channel,context}) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      height: 80.0,
      width: 100,
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
                builder: (context)=> ChannelScreen(channel: channel)),);
        },
              child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 35.0,
              backgroundImage: NetworkImage(channel.profilePictureUrl),
            ),
            // SizedBox(width: 12.0),
            channel.title=='မဟာ' ? Text(
                    'Mahar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ): Text(
                    channel.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
          ],
        ),
      ),
    );
  }

Widget channelTitle({Channel channel, context}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: <Widget>[
          Container(
            width: 250,
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
          child: channel.title=='မဟာ' 
                ?Text('Mahar', 
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20, color: Colors.white),):
                Text(channel.title, 
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20, color: Colors.white),)
                ,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffecba1a),
          ),
          
            child: OutlineButton(
              color: Colors.yellow[700],
            child: Text("See All"),
            onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                builder: (context)=> ChannelScreen(channel: channel)),);
            },
            ),
        )
        ],
        ),
    );
  }

Widget videoListView({Channel channel,context}){
  return channel.videos.length!=0?
        Container(
          height: 140,
          child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          Video video = channel.videos[index];
          return buildVideo(video: video, context: context);
        },
      ),
    ):
    Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            );
  }

Widget buildVideo({Video video,context}) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(video: video,),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xff1e2747),
        ),
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
        padding: EdgeInsets.all(10.0),
        height: 50.0,
        child: Column(children: <Widget>[
          ClipRRect(
                  child: Image.network(
                    video.thumbnailUrl,
                width: 150.0,
                height: 80,
                fit: BoxFit.cover,
              ),
          ),
            SizedBox(height: 5.0),
            Container(
              width: 150,
              height: 30,
              child: Text(
                video.title,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                ),
              ),
            ),
        ],),
      ),
    );
  }

Widget buildVideoChannel({Video video,context}) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(video: video,),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xff1e2747),
        ),
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.network(video.thumbnailUrl),
              ),
            Expanded(
              child: Text(
                  video.title,
                  textAlign: TextAlign.left,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 2,
                    color: Colors.white,
                    fontSize: 11.0,
                  ),
                ),
            ),
        ],),
      ),
    );
  }

 Widget showMessage(BuildContext context,String message){
      return Flushbar(
         message: message,
                duration:  Duration(seconds: 3), 
                // margin: EdgeInsets.only(bottom: 50),             
                )..show(context);
  }