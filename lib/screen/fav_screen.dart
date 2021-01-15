import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:youTubeApp/components/appbar_widget.dart';
import 'package:youTubeApp/model/video.dart';
import 'package:youTubeApp/screen/video_screen.dart';
import 'package:youTubeApp/util/favouriteVideos.dart';

class FavScreen extends StatefulWidget {
  static const String routeName= '/fav';
  final FavoriteVideos favs = FavoriteVideos();
  FavScreen({Key key}) : super(key: key);

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  BannerAd myBannerAd;
  List<Video> videoList = new List();
  List<Video> videos;

  BannerAd biuldBannerAd(){
    return BannerAd(
      adUnitId: 'ca-app-pub-8107971978330636/6213831627',
      size: AdSize.banner,
      listener: (MobileAdEvent event){
        if (event == MobileAdEvent.loaded){
          myBannerAd..show();
        }
        print("BannerAd $event");
      },
    );
  }

  // load favorite videos
  loadFavourite() async {
    List<Video> videos =await widget.favs.readAllFavorites();
    setState(() {
      videoList = videos;
    });
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-8107971978330636~8056578093');
    // myBannerAd = biuldBannerAd()..load();
    super.initState();
    loadFavourite();
  }

  @override
  void dispose() { 
    // myBannerAd.dispose();
    super.dispose();
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

              // favourite video list
              Container(
                child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: videoList.length,
                      itemBuilder: (BuildContext context, int index){
                          return GestureDetector(
                            onTap: () =>
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VideoScreen(video: videoList[index],),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff1e2747),
                                  borderRadius: BorderRadius.circular(20)),
                                padding: EdgeInsets.symmetric(horizontal:10, vertical: 10),
                                margin: EdgeInsets.symmetric(horizontal: 10, vertical:10),
                                child: Row(children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  videoList[index].thumbnailUrl,
                                  width: 100.0,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding:  EdgeInsets.only(left: 10),
                                    alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                      Text(videoList[index].title, style: TextStyle(color: Colors.white)),
                                      Text(videoList[index].channelTitle, style: TextStyle(color: Colors.blue),),
                                    ],),
                                  ),
                                )
                              ],),
                            ),
                        );
                      }
                  ),
              )
            ],),)
       ),
    );
  }
}