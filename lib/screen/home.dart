import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:youTubeApp/components/appbar_widget.dart';
import 'package:youTubeApp/components/widget.dart';
import 'package:youTubeApp/model/channel.dart';
import 'package:youTubeApp/services/ads.dart';
import 'package:youTubeApp/services/api_service.dart';
import 'package:youTubeApp/util/keys.dart';
import 'package:connectivity/connectivity.dart';
import 'package:admob_flutter/admob_flutter.dart';

class Home extends StatefulWidget {
  static const String routeName= '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  BannerAd myBannerAd;
  AdmobInterstitial interstitialAd;
  List<Channel> channels = new List();
  Channel channel;
  bool errorExist = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // if there is not cache,load videos.
    if(channelCache.length == 0){
      getVideos();
    } else { 
      setState(() {
        channels = channelCache;
        isLoading = false;
        errorExist = false;
      });
    }
    interstitialAd = AdManager.initFullScreenAd(interstitialAd);
    interstitialAd.load();
  }

  // get videos from the api
  Future getVideos() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    isLoading = true;
    errorExist = false;
    // Check if connection exist
    if (connectivityResult != ConnectivityResult.none) {
        for(int i=0; i<channelIDs.length; i++){
          channel = new Channel();
          channel = await APIService.instance
            .fetchChannel(channelId: channelIDs[i]);
          setState(() {
            channels.add(channel);
            channelCache.add(channel);

            // For error handling, check loading is finished? and is error exist?
            if(i == channelIDs.length-1){
              isLoading = false;
              if(channelCache.length == 0){
                errorExist = true;
              }else{
                errorExist = false;
              }
            }
          });
        }
    } else{
      setState(() {
        errorExist = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff141a32),
      appBar: mainAppBar(),
      drawer: drawerWidget(context),
      body: errorExist ? 

          // Show error image
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/error.png',
                     colorBlendMode: BlendMode.hardLight,
                  width: 300.0,
                  height: 200,
                  fit: BoxFit.cover,
                ),
            ),
            SizedBox(height: 20,),
              Text('Failed to load videos. Please try again!',
                   style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffecba1a),
                  ),
                  child: OutlineButton(
                    color: Colors.yellow[700],
                    child: Text("Tap to Retry"),
                    onPressed: (){
                      getVideos();
                    },
                ),
              ),
            ],)
          ):

          !isLoading ?
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children: <Widget>[
                
            // Show channel profiles
                Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: channels.length,
                  itemBuilder: (BuildContext context, int index){
                                 return buildProfileInfo(channel: channels[index],context: context);
                }),
              ),

              AdManager.largeBannerAdWidget(),

              // Show videos container
              Container(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: channels.length,
                  separatorBuilder: (BuildContext context, int index){
                    return (index != 0 && index % 5 == 0) ? AdManager.largeBannerAdWidget(): SizedBox.shrink();
                  },
                  itemBuilder: (BuildContext context, int index){
                                 return Column(
                                   children:<Widget>[
                                     channelTitle(channel:channels[index], context: context),
                                     videoListView(channel: channels[index],context: context,interstitialAd: interstitialAd),
                                     SizedBox(height: 15),
                                   ]
                                 );
                }),
              ),
            AdManager.largeBannerAdWidget(),
            ],
            ),
          )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            ),
    );
  }
}