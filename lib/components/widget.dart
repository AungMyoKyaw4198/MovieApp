import 'package:admob_flutter/admob_flutter.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:youTubeApp/model/channel.dart';
import 'package:youTubeApp/model/video.dart';
import 'package:youTubeApp/screen/channel_screen.dart';
import 'package:youTubeApp/screen/video_screen.dart';
import 'package:youTubeApp/services/ads.dart';

class BuildProfileInfoWidget extends StatelessWidget {
  final Channel channel;
  final BuildContext context;
  const BuildProfileInfoWidget({this.channel,this.context});

  @override
  Widget build(BuildContext context) {
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
}

class ChannelTitleWidget extends StatelessWidget {
  final Channel channel;
  final BuildContext context;
  const ChannelTitleWidget({this.channel, this.context});

  @override
  Widget build(BuildContext context) {
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
          
            child: OutlinedButton(
            child: Text("See All",style: TextStyle(color: Colors.black),),
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
}

class VideoListViewWidget extends StatelessWidget {
  final Channel channel;
  final BuildContext context;
  final AdmobInterstitial interstitialAd;

  const VideoListViewWidget({this.channel,this.context,this.interstitialAd});

  @override
  Widget build(BuildContext context) {
    return channel.videos.length!=0?
        channel.id == 'UCBZWU1iRrtll1QoO9O_rD_w' ?
            Container(
              height: 140,
              child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return BuildVideoWidget(video: channel.videos[index], context: context);
            },
          ),
        )
        :Container(
          height: 140,
          child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return BuildVideoWidget(video: channel.videos[index], context: context, interstitialAd: interstitialAd);
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
}

class BuildVideoWidget extends StatelessWidget {
  final Video video;
  final BuildContext context;
  final AdmobInterstitial interstitialAd;
  const BuildVideoWidget({this.video,this.context,this.interstitialAd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        AdManager.loadFullScreenAd(interstitialAd);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoScreen(video: video,),
          ),
        );
      } ,
        
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
}

class BuildVideoChannelWidget extends StatelessWidget {
  final Video video;
  final BuildContext context;
  final AdmobInterstitial interstitialAd;
  const BuildVideoChannelWidget({this.video,this.context,this.interstitialAd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        AdManager.loadFullScreenAd(interstitialAd);            
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoScreen(video: video,),
          ),
        );
      },
      
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
}

class ShowMessageWidget extends StatelessWidget {
  final BuildContext context;
  final String message;
  const ShowMessageWidget(this.context,this.message);

  @override
  Widget build(BuildContext context) {
    return Flushbar(
         message: message,
                duration:  Duration(seconds: 3), 
                )..show(context);
  }
}

class FavVideoListViewWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  const FavVideoListViewWidget(this.imageUrl,this.title,this.subTitle);

  @override
  Widget build(BuildContext context) {
     return Container(
          decoration: BoxDecoration(
            color: Color(0xff1e2747),
            borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(horizontal:10, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical:10),
          child: Row(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(imageUrl,height: 80,width: 100, fit: BoxFit.cover,cacheHeight: 200,cacheWidth: 200,),
          ),
          Expanded(
            child: Container(
              padding:  EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Text(title, style: TextStyle(color: Colors.white)),
                Text(subTitle, style: TextStyle(color: Colors.blue),),
              ],),
            ),
          )
        ],),
      );
  }
}
